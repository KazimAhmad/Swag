from flask import jsonify, request
from datetime import date, datetime, timedelta
from sqlalchemy.exc import SQLAlchemyError, IntegrityError

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
    if len(json_thoughts) > 0:
        first_thought = json_thoughts[0]
        return jsonify(
            first_thought
        ), 200
    else :
        return jsonify(
            {
                "error": "no thought today yet"
            }
        ), 400

@app.route("/thoughts", methods = ["GET"])
def thoughts():
    page_number = request.args.get("page", default=1, type=int)
    thoughts = Thought.query.order_by(
        Thought.date.desc()
    ).paginate(per_page=5, page=page_number)

    json_thoughts = list(map(lambda thought: thought.to_json(), thoughts.items))
    
    return jsonify(
        {
            "total": thoughts.total,
            "items": json_thoughts
        }
    ), 200

#create a thought
@app.route("/thoughts/create", methods = ["POST"])
def thought_create():
    new_thought = request.json.get("thought")
    new_more = request.json.get("more")

    if not new_thought or new_thought is None:
        return jsonify(
            {
                "error": "A valid thought is required"
            }
        ), 400
    new_thought = Thought(thought = new_thought,
                        more = new_more)    
    try:
        db.session.add(new_thought)
        db.session.commit()
    
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 400
    new_thought_id = new_thought.id

    return jsonify({"id": new_thought_id}), 201

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

