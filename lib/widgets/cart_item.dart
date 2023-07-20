import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const.dart';
import '../generated/assets.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;

  const CartItem({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            height: 80,
            width: 80,
            child: Image.asset("assets/${cart.product.images[0]}"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "\$${cart.product.price}",
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Text("QTY:",
                  style: TextStyle(
                      color: black.withOpacity(0.2),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 5),
              Text("${cart.quantity}",
                  style: const TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(width: 10),
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
                      cartProvider.reduceQuantity(cart.product);
                    },
                    child: const Icon(Icons.remove)),
                const SizedBox(height: 3),
                GestureDetector(
                    onTap: () {
                    cartProvider.addQuantity(cart.product);
                    },
                    child: const Icon(Icons.add)),
              ],
            ),
          ),

        ],
      ),
    );
  }
}