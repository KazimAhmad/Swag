from config.config import db
from sqlalchemy import Column, Integer, String, ForeignKey, Float

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
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "colors": [self.color_primary, self.color_secondary],
            "color_text": self.color_text,
            "image": self.image_filename,
            "link": self.link
        }