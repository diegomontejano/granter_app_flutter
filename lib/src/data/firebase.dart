import "package:cloud_firestore/cloud_firestore.dart";
import "package:granter_app/src/model/product_model.dart";

class Firebase {
  final collectionProducts = FirebaseFirestore.instance.collection("products");

  Stream<List<ProductModel>> read() {
    return collectionProducts
        .orderBy("title", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              // convert from <JSON String> to <Map<ProductModel>>
              (map) => ProductModel(
                  title: map["title"],
                  type: map["type"],
                  description: map["description"],
                  price: map["price"],
                  rating: map["rating"],
                  created: map["created"],
                  id: map["id"],
                  imageURL: map["imageURL"]),
            )
            .toList());
  }

  update(String title, String type, String description, double price,
      int rating, String created, String id, String imageURL) {
    collectionProducts.doc(id).set({
      "title": title,
      "type": type,
      "description": description,
      "price": price,
      "rating": rating,
      "created": created,
      "id": id,
      "imageURL": imageURL
    });
  }

  delete(String id) {
    collectionProducts.doc(id).delete();
  }
}
