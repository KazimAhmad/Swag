from flask import jsonify, request
from datetime import datetime

import sys
sys.path.append("../config/config.py")
sys.path.append("../models/video.py")

from config.config import db, app
from models.video import Video

#this is a decorater which goes above the function that we are gonna write
@app.route("/videos", methods = ["GET"])
def videos():
    page_number = request.args.get("page", default=1, type=int)
    videos = Video.query.order_by(
        Video.date.desc()
    ).paginate(per_page=10, page=page_number).limit(3).all()

    json_videos = list(map(lambda video: video.to_json(), videos))
    
    return jsonify(
        {
            "videos": json_videos
        }
    )

#create a video
@app.route("/videos/create", methods = ["POST"])
def videos_create():
    new_title = request.json.get("title")
    new_description = request.json.get("description")
    new_link = request.json.get("link")

    
    if not new_title:
        return jsonify(
            {
                "error": "A valid title is required"
            }
        ), 400
    
    if not new_link:
        return jsonify(
            {
                "error": "A valid link is required"
            }
        ), 400
    
    new_video = Video(title = new_title,
                    description = new_description,
                    link = new_link,
                    date = datetime.now(datetime.timezone.utc))    
    try:
        db.session.add(new_video)
        db.session.commit()
    
    except Exception as e:
        return jsonify({"message": str(e)}), 400
    
    return jsonify({"message": "video created"}), 201