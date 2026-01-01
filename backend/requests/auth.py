from flask import jsonify, request, session, send_from_directory
import sys
sys.path.append("../config/config.py")
sys.path.append("../models/user.py")

from config.config import db, app
from models.user import User

#this is a decorater which goes above the function that we are gonna write
@app.route("/users", methods = ["GET"])
def get_users():
    users = User.query.all()
    json_users = list(map(lambda user: user.to_json(), users))

    return jsonify(
        {
            "users": json_users
        }
    )

#create a user
@app.route("users/sign-up", methods = ["POST"])
def create_user():
    