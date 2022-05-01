import "package:auto_size_text_pk/auto_size_text_pk.dart";
import "package:flutter/material.dart";
import "package:granter_app/src/viewmodel/product_viewmodel.dart";
import "package:granter_app/src/views/card_edit.dart";
import "package:granter_app/src/widgets/custom_button.dart";
import "package:intl/intl.dart";
import "package:provider/src/provider.dart";

class CardView extends StatelessWidget {
  // attributes
  final String title;
  final String type;
  final String description;
  final double price;
  final int rating;
  final String created;
  final String id;
  final String imageURL;

  // constructor
  const CardView({
    required this.title,
    required this.type,
    required this.description,
    required this.price,
    required this.rating,
    required this.created,
    required this.id,
    required this.imageURL,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // instance of ProductViewModel (provider from main.dart)
    final productViewModel = context.watch<ProductViewModel>();

    return Container(
      height: 140,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffe0e0e0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffc9c9c9),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageURL), // imageURL attribute
          fit: BoxFit.cover,
          opacity: 0.08,
        ),
      ),
      child: Row(
        children: [
          // Widget 1 - image
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: NetworkImage(imageURL), // imageURL attribute
                    fit: BoxFit.cover),
              ),
            ),
          ),
          // Widget 2 - information
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title, // title attribute
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                          child: const Icon(Icons.more_horiz_outlined),
                          onTap: () {
                            // send data from CardView() to ProductViewModel()
                            productViewModel.titleCardSelected.text = title;
                            productViewModel.typeCardSelected = type;
                            productViewModel.descriptionCardSelected.text =
                                description;
                            productViewModel.imageURLCardSelected = imageURL;
                            productViewModel.priceCardSelected.text =
                                price.toString();
                            productViewModel.ratingCardSelected = rating;
                            productViewModel.createdCardSelected = created;
                            productViewModel.idCardSelected = id;

                            // show CardEdit()
                            showDialog(
                                context: context,
                                builder: (context) => CardEdit());
                          }),
                    ],
                  ),
                  Text(
                    type, // subtitle attribute
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AutoSizeText(
                    DateFormat("dd/MM/yy").format(
                            DateTime.parse(created)) + // created attribute
                        "  " +
                        description, // description attribute
                    maxLines: 2,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    wrapWords: true,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        rating >= 1 // rating attribute
                            ? Icons.star_outlined
                            : Icons.star_outline_outlined,
                        color: const Color(0xffff5429),
                      ),
                      Icon(
                        rating >= 2
                            ? Icons.star_outlined
                            : Icons.star_outline_outlined,
                        color: const Color(0xffff5429),
                      ),
                      Icon(
                        rating >= 3
                            ? Icons.star_outlined
                            : Icons.star_outline_outlined,
                        color: const Color(0xffff5429),
                      ),
                      Icon(
                        rating >= 4
                            ? Icons.star_outlined
                            : Icons.star_outline_outlined,
                        color: const Color(0xffff5429),
                      ),
                      Icon(
                        rating >= 5
                            ? Icons.star_outlined
                            : Icons.star_outline_outlined,
                        color: const Color(0xffff5429),
                      ),
                      const Spacer(),
                      Text(
                        "R\$ ${price.toString().replaceAll(".", ",")}", // price attribute
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
