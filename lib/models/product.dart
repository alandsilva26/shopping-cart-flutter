import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String barcodeValue;
  final String productName;
  final String productVariant;
  final double productPrice;
  final String productImage;
  int quantity = 1;

  Product({
    @required this.id,
    @required this.barcodeValue,
    @required this.productName,
    @required this.productVariant,
    @required this.productPrice,
    @required this.productImage,
  });

  factory Product.fromJson(Map<String , dynamic> jsonData) {
    return Product(
      id: jsonData["_id"].toString(),
      barcodeValue: jsonData["barcodeValue"],
      productName: jsonData["productName"],
      productVariant: jsonData["productVariant"],
      productPrice: jsonData["productPrice"],
      productImage: jsonData["productImage"],
    );
  }
}
