from flask import Flask, request, jsonify
import json
class Bill:
    def __init__(self, listofItems, tax, subTotal):
        self.listofItems = listofItems
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
bill = Bill([], 0.0, 0.0)

@app.route('/get_data', methods=['GET'])
def get_data():
    return request_data
    
@app.route('/get_items', methods=['GET'])
def get_items():
    return json.dumps(items)

@app.route('/parse_items', methods=['GET', 'POST'])
def parse_items():
    global request_data
    global items

    bill = Bill([], 0.0, 0.0)
    if request.method == 'GET':
        return jsonify({'message': 'Hello, world!'})
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        request_data = request.data
        print(request_data)
        items = list(request_data.values())[0] 
        # for item in request_data['items']:
        #     one = Item(item['quantity'],item['name'],item['price'])
        #     items.append(one)

        for item in items:
            first_item = items[0]
            name = first_item['name']
            quantity = first_item['quantity']
            price = first_item['price']

            order = Item(int(quantity), name, float(price))
            bill.listofItems.append(order)

        bill.tax = list(request_data.values())[1]
        bill.subTotal = list(request_data.values())[2]


        # for item in items:
        #     parts = item.split(';')
        #     print(parts)
        #     if (len(parts) == 2):
        #         name, price = parts
        #         parsed_items.append({'quantity': 1,'name': name, 'price': float(price)})
        #     else:
        #         quantity, name, price = parts
        #         parsed_items.append({'quantity': int(quantity),'name': name, 'price': float(price)})    
        return bill




if __name__ == '__main__':
    app.run(debug=True)

