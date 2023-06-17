import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:yummy_express/models/product_model/product_model.dart';
import 'package:yummy_express/provider/app_provider.dart';
import 'package:yummy_express/screens/category_view/category_view_screen.dart';
import 'package:yummy_express/screens/product_details/product_details_screen.dart';
import 'package:yummy_express/widgets/top_titles/top_titles.dart';

import '../../models/category_model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  ///backup code...
  // Future<void> getCategoryList() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
  //   productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
  //   productModelList.shuffle();
  //
  //
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitles(
                          title: "",
                          subtitle: "Yummy Express,",
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Search here"),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Best Product is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: CategoryViewScreen(
                                                categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, left: 12),
                    child: Text(
                      "Best Product",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: 4,
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
                                                "Buy Now",
                                              )))
                                    ],
                                  ),
                                );
                              }),
                        ),
                  const SizedBox(height: 12)
                ],
              ),
            ),
    );
  }
}
