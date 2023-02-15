class SubscriptionRequestBody {
  static Map<String, dynamic> toJson(String channelId) {
    return {
      "snippet": {
        "resourceId": {
          "kind": "youtube#channel",
          "channelId": channelId,
        }
      }
    };
  }
}
