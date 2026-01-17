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
            "my_story": "Junaid Akram, widely known by his digital moniker GanjiSwag, is a prominent Pakistani digital content creator, comedian, and podcast host. Born on July 18, 1983, he is recognized for his observational humor, social commentary, and Walking Tales series.\nEarly Career: Before transitioning to full-time content creation in 2017, Junaid Akram worked as a supply chain strategist. He holds a Bachelor's degree in Economics from Karachi University.\nContent Platforms: He manages several successful digital channels, including:\nYouTube: His main channel features long-form vlogs, travel stories, and commentary.\nAsk Ganjiswag: A dedicated platform where he provides advice and addresses audience queries on societal issues.\nPodcast: He hosts a popular podcast on Spotify and YouTube, covering culture, current affairs, and interviews with young achievers.\nSignature Series: He is well known for his Walking Tales, where he explores cities globally—such as San Francisco, Shenzhen, and locations in Vietnam—while providing comedic and cultural insights.\nBusiness and Influence Brand Work: As of early 2026, he continues to partner with major brands for promotional content, including MG Motor Pakistan and Tapal Danedar.\nEntrepreneurship: He is the co-founder of Luxe Marketing, based in the UAE.\nGlobal Reach: While based in Karachi, he frequently travels and has lived in Dubai and Riyadh.",
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