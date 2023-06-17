import 'package:flutter/material.dart';
import 'package:yummy_express/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:yummy_express/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Your Orders",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty ||
                snapshot.data == null ||
                !snapshot.hasData) {
              return const Center(
                child: Text("No Order Found"),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        tilePadding: EdgeInsets.zero,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              color: Colors.red.withOpacity(0.5),
                              child: Image.network(
                                orderModel.products[0].image,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.products[0].name,
                                    style: const TextStyle(
                                        // fontSize: 18,
                                       ),
                                  ),

                                  const SizedBox(height: 12),

                                  orderModel.products.length > 1
                                ?SizedBox.fromSize()
                                      : Column(
                                    children: [
                                      Text(
                                          "Quanity:${orderModel.products[0].qty.toString()}",
                                          style: const TextStyle(
                                              fontSize: 12
                                          )
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),
                                  Text(
                                    "Total Price:\$${orderModel.totalPrice.toString()}",
                                    style: const TextStyle(
                                      fontSize: 12
                                      ),
                                  ),
                                  const SizedBox(height: 12),

                                  Text(
                                    "Order Status: ${orderModel.status}",
                                    style: const TextStyle(
                                      fontSize: 12
                                       ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                       children: orderModel.products.length > 1 ? [
                         const Text("hello")
                       ] : [

                       ]
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
