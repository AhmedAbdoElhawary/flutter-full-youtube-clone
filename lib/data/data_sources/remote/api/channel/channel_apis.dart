import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
part 'channel_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelAPIs {
  factory ChannelAPIs(Dio dio, {String baseUrl}) = _ChannelAPIs;

  @GET("channels?part=brandingSettings,contentDetails,statistics,snippet")
  Future<ChannelSubDetails> getSubChannelInfo({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String channelId,
  });

  @GET("subscriptions?part=snippet&mine=true&maxResults=2")
  Future<MySubscriptionsDetails> getMySubscriptionsChannels({
    @Query("key") final String apiKey = apiKey,
    @Query("access_token") required String accessToken,
  });

  /// use in [body] this SubscriptionRequestBody.toJson(channelId)
  /// Try those: The following list contains the [part] names that you can include in the parameter value:
  /// -contentDetails
  /// -id
  /// -snippet
  /// -subscriberSnippet
  @POST("subscriptions?part=snippet")
  Future<dynamic> subscribeToChannel(
      {@Query("key") final String apiKey = apiKey,
      @Body() required Map<String, dynamic> body,
      @Header("Authorization") required String accessToken});

  /// [id] is idToken
  @DELETE("subscriptions")
  Future<dynamic> deleteSubscription({
    @Query("id") required String id,
    @Query("access_token") required String accessToken,
  });
}
