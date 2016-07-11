from flask import Flask
from flask import request, abort
 
app = Flask(__name__)
 
@app.route('/', methods=['GET'])
def index():
    return request.remote_addr
if __name__ == '__main__':
    app.run(host='0.0.0.0')
