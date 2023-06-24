import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';

class SearchForThisSentenceUseCase
    implements
        FutureUseCase<ApiResult<VideosDetails>,
            SearchForThisSentenceUseCasePara> {
  final SearchDetailsRepository _searchDetailsRepository;

  SearchForThisSentenceUseCase(this._searchDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required SearchForThisSentenceUseCasePara params}) {
    return _searchDetailsRepository.searchForThisSentence(
        sentence: params.sentence);
  }
}

class SearchForThisSentenceUseCasePara {
  String sentence;
  SearchForThisSentenceUseCasePara({required this.sentence});
}
