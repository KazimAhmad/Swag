from flask import jsonify, send_from_directory, url_for
from config.config import app

@app.route("/about", methods = ["GET"])
def get_about_info():
    image_url = url_for(
        "images",
        filename="image.jpg",
        _external=True
    )
    cover_image_url = url_for(
        "images",
        filename="cover_image.jpg",
        _external=True
    )

    return jsonify(
        {
            "name": "Junaid Akram",
            "image": image_url,
            "cover_image": cover_image_url,
            "description": "Pakistani Digital content creator who is developing entertaining and educational content for South Asian YouTube audience that extends to other platforms - Instagram, Facebook and Snapchat.",
            "industry": "Media Production",
            "company_size": "11-50 employees",
            "headquarters": "Karachi, Sindh",
            "my_story": "",
            "social_media": {
                            "linkedIn": "https://www.linkedin.com/company/junaid-akram-ganjiswagpk/",
                            "youTube": "https://www.youtube.com/channel/UCFo9mvW4ythx_tgT3NHaw-Q",
                            "instagram": "https://www.instagram.com/ganjiswag/",
                            "facebook": "https://www.facebook.com/junaid.akram",
                            "patreon": "https://www.patreon.com/ganjiswag"
                    }
        }
    )

@app.route("/image_uploads/<filename>")
def get_image(filename):
    return send_from_directory("image_uploads", filename)