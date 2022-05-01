import "package:flutter/material.dart";
import "package:granter_app/app/api/firebase_api.dart";

class ProductViewModel extends ChangeNotifier {
  // instance of FirebaseAPI()
  final _firebase = FirebaseAPI();

  // receive data from CardView()
  final titleCardSelected = TextEditingController();
  String typeCardSelected = "";
  final descriptionCardSelected = TextEditingController();
  final priceCardSelected = TextEditingController();
  int ratingCardSelected = 0;
  String createdCardSelected = "";
  String idCardSelected = "";
  String imageURLCardSelected = "";

  read() {
    return _firebase.read();
  }

  update() {
    _firebase.update(
        titleCardSelected.text,
        typeCardSelected,
        descriptionCardSelected.text,
        double.parse(priceCardSelected.text.replaceAll(",", ".")),
        ratingCardSelected,
        DateTime.now().toString(),
        idCardSelected,
        imageURLCardSelected);
    notifyListeners();
  }

  delete() {
    _firebase.delete(idCardSelected);
    notifyListeners();
  }
}
