from flask import jsonify, request
import sys
sys.path.append("../config/config.py")
sys.path.append("../models/video.py")

from config.config import db, app
from models.fact import Fact
from datetime import datetime

@app.route("/facts", methods = ["GET"])
def facts():
    facts = Fact.query.all()
    facts_to_json = list(map(lambda fact: fact.to_json(), facts))

    return jsonify(
        {
            "facts": facts_to_json
        }
    )

@app.route("/facts/create", methods = ["POST"])
def fact_create():
    new_title = request.json.get("title")
    new_description = request.json.get("description")
    new_link = request.json.get("link")

    if not new_title:
        return jsonify(
            {
                "error": "A valid title is required"
            }
        ), 400
    
    new_fact = Fact(title = new_title,
                    description = new_description,
                    link = new_link,
                    date = datetime.now(datetime.timezone.utc))
    
    try:
        db.session.add(new_fact)
        db.session.commit()
    
    except Exception as e:
        return jsonify(
            {
                "error": str(e) 
            }
        ), 400
    
    return jsonify({"message": "fact created"}), 200




