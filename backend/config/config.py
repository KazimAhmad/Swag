from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_bcrypt import Bcrypt
from config.constants import databaseName, image_uploads, allowed_extensions
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

databaseName = databaseName
image_uploads = image_uploads
allowed_extensions = allowed_extensions

#app configs for data base
app.config["UPLOAD_EXTENSIONS"] = [".jpg", ".png"]
app.config["UPLOAD_PATH"] = image_uploads

app.config["SQLALCHEMY_DATABASE_URI"] = databaseName
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config['SQLALCHEMY_ECHO'] = True
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)