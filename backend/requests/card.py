from flask import jsonify, request
import sys
sys.path.append("../config/config.py")
sys.path.append("../config/constants.py")
sys.path.append("../models/card.py")

from config.config import db, app
from models.card import Card
from requests.image_service import save_image, delete_image
from config.constants import image_uploads, allowed_extensions

@app.route("/cards/create", methods=["POST"])
def create_card():
    title = request.form.get("title")
    description = request.form.get("description")
    link = request.form.get("link")
    color_text = request.form.get("color_text")
    color_secondary = request.form.get("color_secondary")
    color_primary = request.form.get("color_primary")

    file = request.files.get("image")

    filename, error = save_image(
        file,
        image_uploads,
        allowed_extensions
    )

    if error:
        return jsonify({"error": error}), 400
    
    if not title or title is None:
        return jsonify(
            {
                "error": "A valid title is required"
            }
        ), 400
    
    new_card = Card(title= title,
                    description = description,
                    color_primary = color_primary,
                    color_secondary = color_secondary,
                    color_text = color_text,
                    link= link,
                    image_filename = filename)
    try:
        db.session.add(new_card)
        db.session.commit()
    
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 400
    new_card_id = new_card.id

    return jsonify({"id": new_card_id}), 201



@app.route("/cards", methods = ["GET"])
def cards():
    all_cards = Card.query.all()

    json_cards = list(map(lambda card: card.to_json(), all_cards))
    
    return jsonify(
        json_cards
    ), 200

@app.route("/cards", methods = ["DELETE"])
def delete_card():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    cards_to_delete = Card.query.filter(Card.id.in_(ids)).all()

    if not cards_to_delete:
        return jsonify({"error": "No cards found"}), 400
    
    for card in cards_to_delete:
        db.session.delete(card)
        delete_image(card.image_filename, image_uploads)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in cards_to_delete]
    }), 200
