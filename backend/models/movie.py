from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from config.config import db

class MovieCategory(db.Model):
    __tablename__ = "movie_categories"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    facts = relationship("Movie", back_populates="category", cascade="all, delete-orphan")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name
        }


class Movie(db.Model):
    id = db.Column(db.Integer, primary_key = True, nullable = False)
    title = db.Column(db.String(64), nullable = False)
    my_review = db.Column(db.String(256), nullable = False)
    rating = db.Column(db.Integer, nullable = False)
    imdb_link = db.Column(db.String(64), nullable = True)
    release_year = db.Column(db.String(8), nullable = False)

    category_id = Column(Integer, ForeignKey("movie_categories.id"))
    category = relationship("MovieCategory", back_populates="movies")

    def __repr__(self):
        return f"Movie recommendation ('{self.title}', '{self.review}')"
    
    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "my_review": self.my_review,
            "rating": self.rating,
            "imdb_link": self.imdb_link,
            "release_year": self.release_year,
            "category": self.category.to_json()
        }
    