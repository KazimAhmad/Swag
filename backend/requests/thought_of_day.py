from flask import jsonify, request
from datetime import date, datetime, timedelta

import sys
sys.path.append("../config/config.py")
sys.path.append("../models/thought.py")

from config.config import db, app
from models.thought import Thought

#this is a decorater which goes above the function that we are gonna write
@app.route("/thoughts/day", methods = ["GET"])
def thought_day():
    today = date.today()
    start = datetime.combine(today, datetime.min.time())
    end = start + timedelta(days=1)

    thoughts = Thought.query.filter(
        Thought.date >= start,
        Thought.date < end
    ).all()

    json_thoughts = list(map(lambda thought: thought.to_json(), thoughts))
    
    return jsonify(
        {
            "thought_of_day": json_thoughts
        }
    )

@app.route("/thoughts", methods = ["GET"])
def thoughts():
    page_number = request.args.get("page", default=1, type=int)
    thoughts = Thought.query.paginate(per_page=10, page=page_number)

    json_thoughts = list(map(lambda thought: thought.to_json(), thoughts.items))
    
    return jsonify(
        {
            "total": thoughts.total,
            "items": json_thoughts
        }
    )

#create a thought
@app.route("/thoughts/create", methods = ["POST"])
def thought_create():
    new_thought = request.json.get("thought")
    new_more = request.json.get("more")
    
    if not new_thought:
        return jsonify(
            {
                "error": "A valid thought is required"
            }
        ), 400
    new_user = Thought(thought = new_thought,
                      more = new_more,
                      date = datetime.now(datetime.timezone.utc))    
    try:
        db.session.add(new_user)
        db.session.commit()
    
    except Exception as e:
        return jsonify({"message": str(e)}), 400
    
    return jsonify({"message": "thought created"}), 201

@app.route("/thoughts", methods = ["DELETE"])
def delete_thoughts():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    thoughts = Thought.query.filter(Thought.id.in_(ids)).all()

    if not thoughts:
        return jsonify({"error": "No thoughts found"}), 404
    
    for thought in thoughts:
        db.session.delete(thought)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in thoughts]
    }), 200

