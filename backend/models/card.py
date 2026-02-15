from config.config import db, app
from sqlalchemy import Column, Integer, String
from flask import url_for, send_from_directory

class Card(db.Model):
    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)
    description = Column(String, nullable=False)
    color_primary = Column(String(7))
    color_secondary = Column(String(7))
    color_text = Column(String(7))
    image_filename = db.Column(db.String(255), nullable=True)
    link = Column(String, nullable=False)

    def to_json(self):
        image_url = url_for(
        "images",
        filename=self.image_filename,
        _external=True
        
        )
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "colors": [self.color_primary, self.color_secondary],
            "color_text": self.color_text,
            "image": image_url,
            "link": self.link
        }
