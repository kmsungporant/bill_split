class Food {
  final String name;
  final int quantity;
  final double price;

  Food(this.name, this.quantity, this.price);

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'],
        price = json['price'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'quantity': quantity};
}
