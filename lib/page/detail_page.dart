import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_cubit/models/cart_model.dart';
import 'package:shop_app_cubit/models/product_model.dart';
import 'package:shop_app_cubit/page/bag_page.dart';

import '../const.dart';
import '../providers/cart_provider.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedImage = 0;
  int? selectedColor;
  int quantitiy = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            child: Text("Details",
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
              ):const SizedBox();
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: size.width,
            height: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: widget.product.name,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                    decoration: const BoxDecoration(
                        color: grey, shape: BoxShape.circle),
                    child: DropShadow(
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              "assets/${widget.product.images[selectedImage]}",
                              colorBlendMode: BlendMode.modulate,
                              color: selectedColor != null
                                  ? availableColors[selectedColor!]
                                  : white,
                            ))),
                  ),
                ),
                Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.favorite_outline_outlined,
                        color: red,
                      ),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                widget.product.images.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    margin: index == 0
                        ? const EdgeInsets.only()
                        : const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: grey, borderRadius: BorderRadius.circular(10)),
                    child:
                        Image.asset("assets/${widget.product.images[index]}"),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "\$${widget.product.price}",
                            style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                            availableColors.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 0 : 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: selectedColor == index
                                                ? availableColors[index]
                                                : transparent)),
                                    child: Container(
                                      height: 60,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: availableColors[index],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "More compact. More Powerful.",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w600, fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (quantitiy > 1) {
                              setState(() {
                                quantitiy--;
                              });
                            }
                          },
                          child: const Icon(Icons.remove)),
                      const SizedBox(height: 3),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              quantitiy++;
                            });
                          },
                          child: const Icon(Icons.add)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Text("QTY:",
                        style: TextStyle(
                            color: black.withOpacity(0.2),
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 5),
                    Text("$quantitiy",
                        style: const TextStyle(
                            color: black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    cartProvider.addCart(widget.product, quantitiy);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      decoration: BoxDecoration(
                          color: black, borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                          child: Text(
                        "Add yo Bag",
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
      ),
    );
  }
}
