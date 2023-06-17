import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:yummy_express/models/product_model/product_model.dart';
import 'package:yummy_express/screens/custom_bottom_bar/custom_bar_screen.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';

import '../../provider/app_provider.dart';

class CheckOutScreen extends StatefulWidget {
  final ProductModel singleProduct;
  const CheckOutScreen({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(width: 8),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(width: 8),
                  const Text(
                    "Pay Online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 350,
              child: PrimaryButton(
                title: "Pay Now",
                onPressed: () async{
                  appProvider.getBuyProductList.clear();
                  appProvider.addBuyProduct(widget.singleProduct);

                 bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList, context, groupValue == 1 ? "Cash on delivery": "Paid");
                 if (value) {
                   Future.delayed(const Duration(seconds: 2), () {
                     Routes.instance.push(widget: const CustomBottomBarScreen(), context: context);
                   });
                 }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
