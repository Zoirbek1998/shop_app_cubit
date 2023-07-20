import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app_cubit/generated/assets.dart';
import 'package:shop_app_cubit/models/product_model.dart';

import '../const.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Center(
            child: Text("Bag",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //     decoration: const BoxDecoration(
        //         color: yellow,
        //         borderRadius:
        //             BorderRadius.horizontal(left: Radius.circular(20))),
        //     child: const Row(
        //       children: [
        //         Icon(Icons.shopping_bag_outlined, color: black),
        //         const SizedBox(width: 2),
        //         Text(
        //           "3",
        //           style: TextStyle(color: black),
        //         )
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: BlocBuilder<CartProvider, List<CartModel>>(
        bloc: cartProvider,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Bag",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        Text(
                          "${state.length} Items",
                          style: TextStyle(
                              color: black.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    state.length,
                    (index) => Slidable(
                      key: ValueKey(state[index].product.name),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: (){
                            cartProvider.removeCart(state[index].product);
                          },
                        ),
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //    color: yellow,
                          //       borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                          //   ),
                          // ),
                          SlidableAction(
                            padding: EdgeInsets.zero,
                            onPressed: (context) {
                              cartProvider.removeCart(state[index].product);
                            },
                            icon: Icons.close,
                            foregroundColor: Colors.black,
                            backgroundColor: yellow,
                            label: "Remuve",
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                          )
                        ],
                      ),
                      child: CartItem(
                        cart: state[index],
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset.zero,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total",
                            style: TextStyle(
                                color: black.withOpacity(0.2),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 5),
                        Text("\$${cartProvider.getTotal()}",
                            style: const TextStyle(
                                color: black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // cartProvider.addCart(widget.product, quantitiy);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                              child: Text(
                            "Checkout",
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
