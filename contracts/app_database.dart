import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'seeds/quran_preseeded_data.dart';
import 'tables/ayahs_table.dart';
import 'tables/bookmarks_table.dart';
import 'tables/surahs_table.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quran_app_v1.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [SurahsTable, AyahsTable, BookmarksTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedInitialQuranData();
      },
    );
  }

  Future<void> _seedInitialQuranData() async {
    await batch((b) {
      // Seed 114 Surahs
      b.insertAll(
        surahsTable,
        QuranPreseededData.surahs.map(
          (s) => SurahsTableCompanion.insert(
            id: Value(s.id),
            nameArabic: s.nameArabic,
            nameLatin: s.nameLatin,
            translationId: s.translationId,
            numberOfAyahs: s.numberOfAyahs,
            revelationType: s.revelationType,
          ),
        ),
      );

      // Seed Initial Ayahs
      b.insertAll(
        ayahsTable,
        QuranPreseededData.essentialAyahs.map(
          (a) => AyahsTableCompanion.insert(
            surahId: a.surahId,
            ayahNumber: a.ayahNumber,
            textUthmani: a.textUthmani,
            textTajweed: a.textTajweed,
            textTranslation: a.textTranslation,
            pageNumber: a.pageNumber,
            juzNumber: a.juzNumber,
          ),
        ),
      );
    });
  }

  // --- QUERIES ---

  Future<List<SurahsTableData>> getAllSurahs() =>
      (select(surahsTable)..orderBy([(t) => OrderingTerm(expression: t.id)])).get();

  Future<SurahsTableData?> getSurahById(int id) =>
      (select(surahsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<AyahsTableData>> getAyahsBySurah(int surahId) =>
      (select(ayahsTable)
            ..where((t) => t.surahId.equals(surahId))
            ..orderBy([(t) => OrderingTerm(expression: t.ayahNumber)]))
          .get();

  Future<List<AyahsTableData>> searchAyahs(String query) =>
      (select(ayahsTable)
            ..where((t) => t.textTranslation.like('%$query%') | t.textUthmani.like('%$query%'))
            ..limit(50))
          .get();

  Future<int> saveBookmark(int surahId, int ayahNumber, String surahNameLatin) =>
      into(bookmarksTable).insert(
        BookmarksTableCompanion.insert(
          surahId: surahId,
          ayahNumber: ayahNumber,
          surahNameLatin: surahNameLatin,
          createdAt: Value(DateTime.now()),
        ),
      );

  Future<BookmarksTableData?> getLastReadBookmark() =>
      (select(bookmarksTable)
            ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
            ..limit(1))
          .getSingleOrNull();
}
