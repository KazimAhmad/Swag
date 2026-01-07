from flask import jsonify, request, session, send_from_directory
import sys
sys.path.append("../config/config.py")
sys.path.append("../models/user.py")

from config.config import db, app, bcrypt
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
    new_user_name = request.json.get("userName")
    new_email = request.json.get("email")
    new_password = request.json.get("password")
    
    if not new_user_name:
        return jsonify(
            {
                "error": "A valid user name is required"
            }
        ), 400
    elif not new_email:
         return jsonify(
            {
                "error": "A valid email is required"
            }
        ), 400
    elif not new_password:
         return jsonify(
            {
                "error": "A valid password is required"
            }
        ), 400
    #same username or email validation
    same_user_name = User.query.filter_by(new_user_name).first()
    if same_user_name:
        return jsonify(
            {
                "error": "a user with same username already exists"
            }
        ), 400
    same_email = User.query.filter_by(new_email).first()
    if same_email:
        return jsonify(
            {
                "error": "a user with same email already exists"
            }
        ), 400

    hashed_password = bcrypt.generate_password_hash(new_password).decode('utf-8')
    new_user = User(user_name = new_user_name,
                    email = new_email,
                    password = new_password)
    
    try:
        db.session.add(new_user)
        db.session.commit()
    
    except Exception as e:
        return jsonify({"message": str(e)}), 400
    
    return jsonify({"message": "User Created"}), 201
