import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:granter_app/src/viewmodel/product_viewmodel.dart";
import "package:granter_app/src/views/product_list.dart";
import "package:provider/provider.dart";

Future main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(
    // MultiProvider: allow multiple providers on root class
    MultiProvider(
      providers: [
        // provider from ProductViewModel()
        ChangeNotifierProvider(create: (_) => ProductViewModel())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Granter App",
        home: ProductList(),
      ),
    ),
  );
}
