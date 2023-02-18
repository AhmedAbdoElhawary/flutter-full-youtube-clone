class SuggestionTexts {
  List<dynamic> suggestions;

  SuggestionTexts({required this.suggestions});

  static SuggestionTexts fromJson(List<dynamic> json) =>
      SuggestionTexts(suggestions: (json)[1]);
}
