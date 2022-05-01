import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:granter_app/src/viewmodel/product_viewmodel.dart";
import "package:granter_app/src/widgets/real_formatter.dart";
import "package:granter_app/src/widgets/star_rating.dart";
import "package:provider/src/provider.dart";

class CardEdit extends StatelessWidget {
  // _formKey identificator
  final _formKey = GlobalKey<FormState>();

  CardEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // instance of ProductViewModel (provider from main.dart)
    final _productViewModel = context.watch<ProductViewModel>();

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          color: const Color(0xffe0e0e0),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff565656),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(_productViewModel.imageURLCardSelected),
            fit: BoxFit.cover,
            opacity: 0.10,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(
                        width: 60,
                        child: Text(
                          "Type: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        child: DropdownButtonFormField(
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(child: Text("dairy"), value: "dairy"),
                        DropdownMenuItem(child: Text("fruit"), value: "fruit"),
                        DropdownMenuItem(
                            child: Text("vegetable"), value: "vegetable"),
                        DropdownMenuItem(child: Text("vegan"), value: "vegan"),
                        DropdownMenuItem(
                            child: Text("bakery"), value: "bakery"),
                        DropdownMenuItem(child: Text("meat"), value: "meat"),
                      ],
                      value: _productViewModel.typeCardSelected,
                      onChanged: (value) {
                        _productViewModel.typeCardSelected = value.toString();
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                        width: 60,
                        child: Text(
                          "Title: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: TextFormField(
                        controller: _productViewModel.titleCardSelected,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "The title must be filled";
                          }
                          return null; // if valid, return null
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                        width: 60,
                        child: Text(
                          "Desc.: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: TextFormField(
                        maxLines: 2,
                        controller: _productViewModel.descriptionCardSelected,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                        width: 60,
                        child: Text(
                          "Price: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: TextFormField(
                        maxLength: 6,
                        keyboardType:
                            TextInputType.number, // // show numbers keyboard
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // allow only numbers input
                          RealFormatter(), // real formatter
                        ],
                        controller: _productViewModel.priceCardSelected,
                        validator: (value) {
                          if (value == "0,00") {
                            return "The price must be filled";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    SizedBox(
                        width: 60,
                        child: Text("Rating: ",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Expanded(child: StarRating()))
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffff5429),
                            onPrimary: Colors.black87,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          // delete data from db
                          _productViewModel.delete();
                          // close alertdialog
                          Navigator.pop(context);
                          // show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xffff5429),
                              duration: const Duration(seconds: 8),
                              content: const Text(
                                "File deleted",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              action: SnackBarAction(
                                label: "Recover file",
                                textColor: Colors.black87,
                                onPressed: () => _productViewModel.update(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffff5429),
                            onPrimary: Colors.black87,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          // if form pass => true
                          if (_formKey.currentState!.validate()) {
                            // update data to db
                            _productViewModel.update();
                            // close alertdialog
                            Navigator.pop(context);
                            // show snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xffff5429),
                                content: Text(
                                  "File saved",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
