class RatingDetails {
  String rating;

  RatingDetails({this.rating = "none"});

  factory RatingDetails.fromJson(Map<String, dynamic> json) {

    return RatingDetails(rating: json["items"][0]["rating"] ?? "none");
  }
}

