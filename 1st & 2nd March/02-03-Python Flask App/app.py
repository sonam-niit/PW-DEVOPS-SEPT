from flask import Flask,render_template,jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello From Flask!"

## Templates folder by default it will search
@app.route('/portfolio')
def portfolio():
    return render_template('index.html')
## URL Parameters
@app.route('/user/<name>')
def user(name):
    return f"Welcome, {name}"

## JSON Response
@app.route('/api')
def api():
    return jsonify({"message":"Welcome to My Flask APP"})

@app.route('/about')
def about():
    return "this is my aboout Us Page!"

if __name__=='__main__':
    app.run(debug=True)