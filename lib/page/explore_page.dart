import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_cubit/const.dart';
import 'package:shop_app_cubit/generated/assets.dart';
import 'package:shop_app_cubit/models/cart_model.dart';
import 'package:shop_app_cubit/models/product_model.dart';
import 'package:shop_app_cubit/page/detail_page.dart';
import 'package:shop_app_cubit/providers/cart_provider.dart';

import '../widgets/product_item.dart';
import 'bag_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.transparent,
        ),
        title: const Center(
            child: Text("Explore",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<CartProvider, List<CartModel>>(
            bloc: cartProvider,
            builder: (context, state) {
              return state.isNotEmpty ? GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BagPage()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                      color: yellow,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20))),
                  child:  Row(
                    children: [
                      const Icon(Icons.shopping_bag_outlined, color: black),
                      const SizedBox(width: 2),
                      Text(
                        "${state.length}",
                        style:const TextStyle(color: black),
                      )
                    ],
                  ),
                ),
              ): const SizedBox();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            spacing: 20,
            children: [
              ...List.generate(
                  products.length,
                  (index) => Padding(
                        padding: EdgeInsets.only(top: index % 2 == 1 ? 50 : 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            product: products[index],
                                          )));
                            },
                            child: ProductItem(
                              product: products[index],
                            )),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
