from config.config import db
from enum import Enum

class BookCategory(str, Enum):
    action = "action"
    comedy = "comedy"
    drama = "drama"

class Book(db.Model):
    id = db.Column(db.Integer, primary_key = True, nullable = False)
    title = db.Column(db.String(64), nullable = False)
    review = db.Column(db.String(256), nullable = False)
    category = db.Column(db.String(16), nullable = False)
    rating = db.Column(db.Integer, nullable = False)
    link = db.Column(db.String(64), nullable = True)
    release_year = db.Column(db.String(8), nullable = False)

    def __repr__(self):
        return f"Book recommendation ('{self.title}', '{self.review}')"
    
    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "review": self.review,
            "category": self.category,
            "rating": self.rating,
            "imdb_link": self.imdb_link,
            "release_year": self.release_year,
        }