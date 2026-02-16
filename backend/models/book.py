from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship
from config.config import db

class Book(db.Model):
    id = db.Column(db.Integer, primary_key = True, nullable = False)
    title = db.Column(db.String(64), nullable = False)
    review = db.Column(db.String(256), nullable = False)
    category = db.Column(db.String(16), nullable = False)
    rating = Column(Float, nullable = False)
    link = db.Column(db.String(64), nullable = True)
    release_year = db.Column(db.String(8), nullable = False)

    category_id = Column(Integer, ForeignKey("book_category.id"))
    category = relationship("BookCategory", back_populates="books")

    def __repr__(self):
        return f"Book recommendation ('{self.title}', '{self.review}')"
    
    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "review": self.review,
            "category": self.category,
            "rating": self.rating,
            "link": self.link,
            "release_year": self.release_year,
            "category": self.category.to_json()
        }

class BookCategory(db.Model):
    __tablename__ = "book_category"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    books = relationship("Book", back_populates="category", cascade="all, delete-orphan")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name
        }
