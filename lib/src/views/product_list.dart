import "package:flutter/material.dart";
import "package:granter_app/src/model/product_model.dart";
import "package:granter_app/src/viewmodel/product_viewmodel.dart";
import "package:granter_app/src/views/card_view.dart";
import "package:provider/src/provider.dart";

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    // instance of ProductViewModel (from main.dart)
    final _productViewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Center(
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/granter-app.appspot.com/o/images%2Fgranter.png?alt=media&token=1d595a9f-9b6c-4944-98d1-cbc4157a6330",
              height: 44),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _productViewModel.read(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error by loading data"));
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardView(
                    // send data from snapshot to CardView()
                    title: snapshot.data![index].title,
                    type: snapshot.data![index].type,
                    description: snapshot.data![index].description,
                    price: snapshot.data![index].price,
                    rating: snapshot.data![index].rating,
                    created: snapshot.data![index].created,
                    id: snapshot.data![index].id,
                    imageURL: snapshot.data![index].imageURL,
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
