import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/ayah_entity.dart';
import '../entities/surah_entity.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<SurahEntity>>> getSurahList();
  Future<Either<Failure, SurahEntity>> getSurahById(int surahId);
  Future<Either<Failure, List<AyahEntity>>> getAyahsBySurahId(int surahId);
  Future<Either<Failure, List<AyahEntity>>> searchAyahs(String query);
  Future<Either<Failure, void>> saveLastRead(int surahId, int ayahNumber, String surahNameLatin);
  Future<Either<Failure, Map<String, dynamic>?>> getLastRead();
}
