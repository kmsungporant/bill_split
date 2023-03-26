class Item {
  late int quantity;
  late String name;
  late double price;

  Item(int quantity, String name, double price) {
    this.quantity = quantity;
    this.name = name;
    this.price = price;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = quantity;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
