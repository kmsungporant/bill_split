import json
from flask import Flask, request, jsonify

app = Flask(__name__)

request_data = ""
items = []
tax = 0.0

user = ""

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


@app.route('/get_account', methods=['GET'])
def get_account():
    return jsonify(username=user)


@app.route('/post_account', methods=['POST'])
def post_account():
    global user
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        request_data = json.loads(request.get_data())
        user = request_data['username']
    return "Error"

@app.route('/parse_items', methods=['POST'])
def parse_items():
    global request_data
    global items
    global tax
    if request.method == 'POST':
        # Handle POST requests as described in the previous example
        request_data = json.loads(request.get_data())
        items = request_data['items']
        tax = request_data['tax']
    return "Error"

if __name__ == '__main__':
    app.run(debug=True)
