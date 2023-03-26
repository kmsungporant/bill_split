from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/parse_items', methods=['GET', 'POST'])
def parse_items():
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        orders = request.json
        items = list(orders.values())[0]
    
        parsed_items = []
        # for item in items:
        #     parts = item.split(';')
        #     print(parts)
        #     if (len(parts) == 2):
        #         name, price = parts
        #         parsed_items.append({'quantity': 1,'name': name, 'price': float(price)})
        #     else:
        #         quantity, name, price = parts
        #         parsed_items.append({'quantity': int(quantity),'name': name, 'price': float(price)})
        return jsonify(parsed_items)
    
if __name__ == '__main__':
    app.run(debug=True)