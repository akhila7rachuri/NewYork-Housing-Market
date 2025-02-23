from flask import Flask, render_template, request, jsonify
import psycopg2
app = Flask(__name__)
@app.route('/static/<path:path>')
def static_file(path):
    return app.send_static_file(path)
@app.route('/')
def index():
    return render_template('index.html')
@app.route('/search', methods=['POST'])
def search():
    state = request.form['state']
    house_type = request.form['house_type']
    priceabove = request.form['price_above']
    pricebelow = request.form['price_below']
    if int(priceabove) < 0 or int(pricebelow) < 0:
        return jsonify({'error': 'Price cannot be negative!'}),
    conn = psycopg2.connect(
        host="localhost",
        database="Newyork_Housing_Market",
        user="postgres",
        password="Ndeepak@192"
    )
    cursor = conn.cursor()
    cursor.execute("""
    SELECT brokertitle, price 
    FROM main_table 
    WHERE state LIKE %s 
    AND type = %s 
    AND price >= %s AND price <= %s
""", ('%' + state.split(',')[0].strip()  + '%', house_type, priceabove,pricebelow))
    brokers = cursor.fetchall()
    cursor.close()
    conn.close()
    result = [{'broker': broker[0], 'price': broker[1]} for broker in brokers]     
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)