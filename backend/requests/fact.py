from flask import jsonify, request
import sys
sys.path.append("../config/config.py")
sys.path.append("../models/video.py")

from config.config import db, app
from models.fact import Fact, FactCategory
import datetime

@app.route("/facts", methods = ["GET"])
def facts():
    page_number = request.args.get("page", default=1, type=int)
    facts = Fact.query.order_by(
        Fact.date.desc()
    ).paginate(per_page=5, page=page_number)

    facts_to_json = list(map(lambda fact: fact.to_json(), facts.items))
    
    return jsonify(
        {
            "total": facts.total,
            "items": facts_to_json
        }
    )

@app.route("/facts/create", methods = ["POST"])
def fact_create():
    new_title = request.json.get("title")
    new_description = request.json.get("description")
    new_link = request.json.get("link")
    new_fact_category = request.json.get("category")
    
    new_fact_category_name = new_fact_category["name"]

    fact_category = FactCategory.query.filter_by(name = new_fact_category_name).first()

    if not new_title:
        return jsonify(
            {
                "error": "A valid title is required"
            }
        ), 400
    
    if not fact_category:
        return jsonify(
            {
                "error": "A valid category is required"
            }
        ), 400
    
    new_fact = Fact(title = new_title,
                    description = new_description,
                    link = new_link,
                    date = datetime.datetime.now(datetime.timezone.utc),
                    category = fact_category)
    
    try:
        db.session.add(new_fact)
        db.session.commit()
    
    except Exception as e:
        return jsonify(
            {
                "error": str(e) 
            }
        ), 400
    
    new_fact_id = new_fact.id
    return jsonify({"id": new_fact_id}), 201

@app.route("/facts", methods = ["DELETE"])
def delete_facts():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    facts = Fact.query.filter(Fact.id.in_(ids)).all()

    if not facts:
        return jsonify({"error": "No facts found"}), 404
    
    for fact in facts:
        db.session.delete(fact)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in facts]
    }), 200

@app.route("/facts/category/create", methods = ["POST"])
def fact_category_create():
    new_name = request.json.get("name")

    same_category = FactCategory.query.filter_by(name = new_name).first()
    if same_category:
        return jsonify(
            {
                "error": "a fact category with same name already exists"
            }
        ), 400
    
    if not new_name:
        return jsonify(
            {
                "error": "A valid name is required"
            }
        ), 400
    
    new_fact_category = FactCategory(name = new_name)
    
    try:
        db.session.add(new_fact_category)
        db.session.commit()
    
    except Exception as e:
        return jsonify(
            {
                "error": str(e) 
            }
        ), 400
    
    new_fact_category_id = new_fact_category.id
    return jsonify({"id": new_fact_category_id}), 201


@app.route("/facts/categories", methods = ["GET"])
def facts_categories():
    fact_cats = FactCategory.query.all()
    fact_cats_to_json = list(map(lambda fact: fact.to_json(), fact_cats))

    return jsonify(
        fact_cats_to_json
    )