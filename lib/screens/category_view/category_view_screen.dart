import 'package:flutter/material.dart';
import 'package:yummy_express/models/category_model/category_model.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../models/product_model/product_model.dart';
import '../product_details/product_details_screen.dart';

class CategoryViewScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryViewScreen({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  SizedBox(height: kToolbarHeight*1),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                         const BackButton(),
                          Text(
                            widget.categoryModel.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                    ),

                    productModelList.isEmpty
                        ? const Center(
                      child: Text("Categories is empty"),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: productModelList.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (ctx, index) {
                            ProductModel singleProduct =
                            productModelList[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.red.withOpacity(0.2),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Image.network(
                                    singleProduct.image,
                                    width: 100,
                                    height: 80,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    singleProduct.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  Text("Price \$${singleProduct.price}"),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                      width: 100,
                                      height: 40,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget:
                                                ProductDetailsScreen(
                                                    singleProduct:
                                                    singleProduct),
                                                context: context);
                                          },
                                          child: const Text(
                                            "Buy",
                                          )))
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 12)
                  ],
                ),
            ));
  }
}
