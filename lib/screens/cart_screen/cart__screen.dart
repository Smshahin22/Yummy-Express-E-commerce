import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/provider/app_provider.dart';
import 'package:yummy_express/screens/cart_screen/widgets/single_cart_item.dart';

import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cart Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: 300,
                child: PrimaryButton(
                  title: "Checkout",
                  onPressed: (){
                    // Routes.instance.push(widget: CheckOutScreen(), context: context);
                  },
                ),
              )
            ],
          ),
        ),
      ),

      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Empty "),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                    singleProduct: appProvider.getCartProductList[index]);
              }),
    );
  }
}
