from config.config import db
from datetime import datetime

class Fact(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    title = db.Column(db.String(120), nullable = False)
    description = db.Column(db.String(256), nullable = True) 
    date = db.Column(db.DateTime, nullable = False, default= datetime.now(datetime.timezone.utc))
    link = db.Column(db.String(120), nullable = True)

    def __repr__(self):
        return f"Fact machine ('{self.title}', '{self.description}')"
    
    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "link": self.link,
            "date": self.date
        }
    