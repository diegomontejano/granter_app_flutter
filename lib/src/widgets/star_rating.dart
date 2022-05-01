import "package:flutter/material.dart";
import "package:granter_app/src/viewmodel/product_viewmodel.dart";
import "package:provider/src/provider.dart";

class StarRating extends StatefulWidget {
  const StarRating({Key? key}) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    // instance of ProductViewModel (provider from main.dart)
    final _productViewModel = context.watch<ProductViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              setState(() => _productViewModel.ratingCardSelected = 1);
            },
            child: Icon(
                _productViewModel.ratingCardSelected >= 1
                    ? Icons.star_outlined
                    : Icons.star_outline_outlined,
                size: 33,
                color: const Color(0xffff5429))),
        GestureDetector(
            onTap: () {
              setState(() => _productViewModel.ratingCardSelected = 2);
            },
            child: Icon(
                _productViewModel.ratingCardSelected >= 2
                    ? Icons.star_outlined
                    : Icons.star_outline_outlined,
                size: 33,
                color: const Color(0xffff5429))),
        GestureDetector(
            onTap: () {
              setState(() => _productViewModel.ratingCardSelected = 3);
            },
            child: Icon(
                _productViewModel.ratingCardSelected >= 3
                    ? Icons.star_outlined
                    : Icons.star_outline_outlined,
                size: 33,
                color: const Color(0xffff5429))),
        GestureDetector(
            onTap: () {
              setState(() => _productViewModel.ratingCardSelected = 4);
            },
            child: Icon(
                _productViewModel.ratingCardSelected >= 4
                    ? Icons.star_outlined
                    : Icons.star_outline_outlined,
                size: 33,
                color: const Color(0xffff5429))),
        GestureDetector(
            onTap: () {
              setState(() => _productViewModel.ratingCardSelected = 5);
            },
            child: Icon(
                _productViewModel.ratingCardSelected >= 5
                    ? Icons.star_outlined
                    : Icons.star_outline_outlined,
                size: 33,
                color: const Color(0xffff5429))),
      ],
    );
  }
}
