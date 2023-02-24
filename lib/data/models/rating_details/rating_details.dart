class RatingDetails {
  Rating rating;

  RatingDetails({this.rating = Rating.non});

  factory RatingDetails.fromJson(Map<String, dynamic> json) {
    return RatingDetails(rating: json["items"][0]["rating"] ?? Rating.non);
  }
}

enum Rating { like, dislike, non }
