from flask import Flask, request

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    # Here you can add your authentication logic to validate the username and password
    return 'Logged in successfully'

if __name__ == '__main__':
    app.run()
