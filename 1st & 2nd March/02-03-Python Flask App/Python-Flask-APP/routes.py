from flask import Flask,request,jsonify
from database import get_db_connection
from models import create_table

app = Flask(__name__)

@app.route('/users')
def get_users():
    print('triggered')
    conn= get_db_connection()
    cursor= conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM users')
    users= cursor.fetchall()
    print(users)
    cursor.close()
    conn.close()
    return jsonify(users)

@app.route('/test')
def test():
    create_table()
    return "Table Created Successfully!"