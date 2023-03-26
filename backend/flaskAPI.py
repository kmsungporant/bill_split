from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/parse_items', methods=['GET', 'POST'])
def parse_items():
    bill = Bill([], 0.0, 0.0)
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        orders = request.json
        items = list(orders.values())[0]

        for item in items:
            first_item = items[0]
            name = first_item['name']
            quantity = first_item['quantity']
            price = first_item['price']

            order = Items(int(quantity), name, float(price))
            bill.list.append(order)

        bill.tax = list(orders.values())[1]
        bill.subTotal = list(orders.values())[2]


        # for item in items:
        #     parts = item.split(';')
        #     print(parts)
        #     if (len(parts) == 2):
        #         name, price = parts
        #         parsed_items.append({'quantity': 1,'name': name, 'price': float(price)})
        #     else:
        #         quantity, name, price = parts
        #         parsed_items.append({'quantity': int(quantity),'name': name, 'price': float(price)})
        return jsonify("store item successful")
    
    if request.method == 'GET':
        return bill

class Bill:
    def __init__(self, list, tax, subTotal):
        self.list = []
        self.tax = tax
        self.subTotal = subTotal


class Items:
    def __init__(self, quantity, name, price):
        self.quantity = quantity
        self.name = name
        self.price = price


if __name__ == '__main__':
    app.run(debug=True)
