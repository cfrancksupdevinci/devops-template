# filepath: c:\Users\mlle franck\Documents\IA\devops-template\docker\app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Python app is running!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)