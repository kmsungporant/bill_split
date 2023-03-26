import json
from flask import Flask, request, jsonify
from types import SimpleNamespace


class Bill:
    def __init__(self, list, tax, subTotal):
        self.list = []
        self.tax = tax
        self.subTotal = subTotal


class Item:
    def __init__(self, quantity, name, price):
        self.quantity = quantity
        self.name = name
        self.price = price


app = Flask(__name__)

request_data = ""
items = []
tax = 0.0

def to_json(obj):
    return json.dumps(obj, default=lambda obj: obj.__dict__) 

@app.route('/get_tax', methods=['GET'])
def get_tax():
    return to_json(tax)

@app.route('/get_items', methods=['GET'])
def get_items():
    return to_json(items)


@app.route('/get_data', methods=['GET'])
def get_data():
    return to_json(request_data)


@app.route('/parse_items', methods=['GET', 'POST'])
def parse_items():
    global request_data
    global items
    global tax
    if request.method == 'GET':
        return request_data
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        request_data = json.loads(request.get_data())
        items = request_data['items']
        tax = request_data['tax']
    # for item in items:
    #     first_item = items[0]
    #     name = first_item['name']
    #     quantity = first_item['quantity']
    #     price = first_item['price']

    #     order = Items(int(quantity), name, float(price))
    #     bill.list.append(order)

    # bill.tax = list(orders.values())[1]
    # bill.subTotal = list(orders.values())[2]

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


if __name__ == '__main__':
    app.run(debug=True)
