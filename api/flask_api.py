
# flask_api.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Flask API Home"
