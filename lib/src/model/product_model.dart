class ProductModel {
  // attributes
  String title;
  String type;
  String description;
  double price;
  int rating;
  String created;
  String id;
  String imageURL;

  // constructor
  ProductModel({
    required this.title,
    required this.type,
    required this.description,
    required this.price,
    required this.rating,
    required this.created,
    required this.id,
    required this.imageURL,
  });
}
