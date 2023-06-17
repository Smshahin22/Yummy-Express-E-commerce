import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/screens/favourite_screen/widgets/single_favourite_item.dart';

import '../../provider/app_provider.dart';
import '../cart_screen/widgets/single_cart_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(
        child: Text("Empty "),
      )
          : ListView.builder(
          itemCount: appProvider.getFavouriteProductList.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            return SingleFavouriteItem(
                singleProduct: appProvider.getFavouriteProductList[index]);
          }),
    );
  }
}
