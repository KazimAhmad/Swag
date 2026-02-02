from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from config.config import db
import datetime

class Fact(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    title = db.Column(db.String(120), nullable = False)
    description = db.Column(db.String(256), nullable = True) 
    date = db.Column(db.DateTime, nullable = False, default= datetime.datetime.now(datetime.timezone.utc))
    link = db.Column(db.String(120), nullable = True)

    category_id = Column(Integer, ForeignKey("fact_categories.id"))
    category = relationship("FactCategory", back_populates="facts")
    def __repr__(self):
        return f"Fact machine ('{self.title}', '{self.description}')"
    
    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "link": self.link,
            "date": self.date,
            "category": self.category.to_json()
        }
    

class FactCategory(db.Model):
    __tablename__ = "fact_categories"

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)

    facts = relationship("Fact", back_populates="category")

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name
        }
