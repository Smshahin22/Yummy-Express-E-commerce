import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/constants/constants.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/models/product_model/product_model.dart';
import 'package:yummy_express/provider/app_provider.dart';
import 'package:yummy_express/screens/cart_screen/cart__screen.dart';

import '../check_out_screen/check_out_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetailsScreen({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance
                    .push(widget: const CartScreen(), context: context);
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.singleProduct.image,
                  height: 300, width: 300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });

                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              Text(
                widget.singleProduct.description,
                style: const TextStyle(fontSize: 16, fontFamily: "Roboto"),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      maxRadius: 15,
                      child: Icon(Icons.remove),
                    ),
                  ),
                  // const SizedBox(width: 12),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  // const SizedBox(width: 12),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      maxRadius: 15,
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
              // const Spacer(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage('Added to Cart');
                    },
                    child: const Text(
                      "Add To Cart",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                      width: 120,
                      height: 38,
                      child: ElevatedButton(
                          onPressed: () {
                            ProductModel productModel = widget.singleProduct.copyWith(qty: qty);
                            Routes.instance.push(
                                widget:  CheckOutScreen(singleProduct: productModel),
                                context: context);
                          },
                          child: const Text("Buy Now")))
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
