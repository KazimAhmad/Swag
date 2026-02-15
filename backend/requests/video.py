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
    ).paginate(per_page=10, page=page_number)

    json_videos = list(map(lambda video: video.to_json(), videos))
    
    return jsonify(
        {
            "total": videos.total,
            "items": json_videos
        }
    )

#create a video
@app.route("/videos/create", methods = ["POST"])
def videos_create():
    new_title = request.json.get("title")
    new_description = request.json.get("description")
    new_link = request.json.get("link")
    new_date = request.json.get("date")
    dt = datetime.strptime(new_date, "%Y-%m-%d %H:%M:%S")
    
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
                    date = dt)    
    try:
        db.session.add(new_video)
        db.session.commit()
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    new_video_id = new_video.id
    return jsonify({"id": new_video_id}), 200

@app.route("/videos", methods = ["DELETE"])
def videos_delete():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    vidoes_to_delete = Video.query.filter(Video.id.in_(ids)).all()

    if not vidoes_to_delete:
        return jsonify({"error": "No videos found"}), 400
    
    for vid in vidoes_to_delete:
        db.session.delete(vid)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in vidoes_to_delete]
    }), 200
