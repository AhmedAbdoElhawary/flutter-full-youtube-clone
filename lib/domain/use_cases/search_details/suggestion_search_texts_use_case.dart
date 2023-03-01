import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';

class SuggestionSearchTextsUseCase
    implements
        FutureUseCase<ApiResult<SuggestionTexts>,
            SuggestionSearchTextsUseCaseParameter> {
  final SearchDetailsRepository _searchDetailsRepository;

  SuggestionSearchTextsUseCase(this._searchDetailsRepository);

  @override
  Future<ApiResult<SuggestionTexts>> call(
      {required SuggestionSearchTextsUseCaseParameter params}) {
    return _searchDetailsRepository.getSuggestionTexts(text: params.text);
  }
}

class SuggestionSearchTextsUseCaseParameter {
  String text;
  SuggestionSearchTextsUseCaseParameter({required this.text});
}
