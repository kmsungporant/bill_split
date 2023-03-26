import 'package:bill_split/models/Item.dart';
import 'dart:convert';

class Bill {
  List<Item> items = [];
  double tax = 0;
  double subTotal = 0;

  Bill(this.items, this.tax, this.subTotal);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = items;
    data['tax'] = tax;
    data['subtotal'] = subTotal;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
