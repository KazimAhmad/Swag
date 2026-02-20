from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship
from config.config import db

class Movie(db.Model):
    __tablename__ = "movie"

    id = Column(Integer, primary_key = True, nullable = False)
    title = Column(String(64), nullable = False)
    my_review = Column(String(256), nullable = False)
    rating = Column(Float, nullable = False)
    imdb_link = Column(String(64), nullable = True)
    release_year = Column(String(8), nullable = False)

    category_id = Column(Integer, ForeignKey("movie_category.id"))
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
    

class MovieCategory(db.Model):
    __tablename__ = "movie_category"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    movies = relationship("Movie", back_populates="category", cascade="all, delete-orphan")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name
        }
