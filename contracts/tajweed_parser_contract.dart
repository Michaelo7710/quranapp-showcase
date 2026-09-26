/// Domain Architecture Contract: Token-Based Tajweed Parsing Engine
/// Note: Concrete regular expression tokenizer and memory cache are maintained in private core.

enum TajweedRule {
  ghunnah,
  idghamBighunnah,
  idghamBilaghunnah,
  iqlab,
  ikhfa,
  qalqalah,
  madWajib,
  madJaiz,
  madAridh,
  waqaf,
}

abstract class ITajweedParser {
  List<dynamic> parseToSpans({
    required String annotatedArabicText,
    required dynamic colors,
    required double fontSize,
    void Function(TajweedRule rule, String title, String description)? onRuleTap,
    void Function(String waqafMark, String title, String description)? onWaqafTap,
  });
}
