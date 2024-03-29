class RestaurantModel {
  final String name;
  final String imageUrl;
  final String discount;
  final String ratings;

  RestaurantModel({
    required this.name,
    required this.imageUrl,
    required this.discount,
    required this.ratings,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json["name"],
      imageUrl: json["primary_image"],
      discount: json["discount"].toString(),
      ratings: json["rating"].toString(),
    );
  }
}
