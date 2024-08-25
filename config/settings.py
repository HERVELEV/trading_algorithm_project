import os 
import yaml 
with open('config/config.yaml', 'r') as file: 
    config = yaml.safe_load(file) 
API_KEY = config['api_key'] 
DB_HOST = config['database']['host'] 
DB_USER = config['database']['user'] 
DB_PASSWORD = config['database']['password'] 
DB_NAME = config['database']['name'] 
SECRET_KEY = os.environ.get('SECRET_KEY', 'your_secret_key') 
