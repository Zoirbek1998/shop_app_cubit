import 'package:flutter/material.dart';

import '../const.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width /2 - 30,
      child: Column(
        children: [
          Hero(
            tag: product.name,
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset("assets/${product.images[0]}"),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5,),
              Text("\$${product.price}" , style:const TextStyle(
                color: black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),),
            ],
          )
        ],
      ),
    );
  }
}