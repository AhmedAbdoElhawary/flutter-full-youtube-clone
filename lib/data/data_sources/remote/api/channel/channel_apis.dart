import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
part 'channel_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelAPIs {
  factory ChannelAPIs(Dio dio, {String baseUrl}) = _ChannelAPIs;

  @GET("channels?part=brandingSettings%2CcontentDetails%2Cstatistics%2Csnippet")
  Future<ChannelSubDetails> getSubChannelInfo({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String channelId,
  });


}
