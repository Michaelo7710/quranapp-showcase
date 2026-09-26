/// Presentation Architecture Contract: Quran BLoC State Machine
/// Note: Concrete state transitions, SQLite DAO calls, and error mappings are maintained in private core.

import 'package:equatable/equatable.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();
}

class LoadSurahs extends QuranEvent {
  @override
  List<Object?> get props => [];
}

class SearchSurah extends QuranEvent {
  final String query;
  const SearchSurah(this.query);
  @override
  List<Object?> get props => [query];
}

class SelectSurah extends QuranEvent {
  final int surahId;
  const SelectSurah(this.surahId);
  @override
  List<Object?> get props => [surahId];
}

class ToggleBookmark extends QuranEvent {
  final int surahId;
  final int ayahNumber;
  const ToggleBookmark(this.surahId, this.ayahNumber);
  @override
  List<Object?> get props => [surahId, ayahNumber];
}
