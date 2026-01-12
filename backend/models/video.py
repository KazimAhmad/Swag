from config.config import db

class Video(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    title = db.Column(db.String(80), nullable = False)
    description = db.Column(db.String(180), nullable = True)
    link = db.Column(db.String(120), unique = True, nullable = False)
    date = db.Column(db.DateTime), nullable = False

    def __repr__(self):
        return f"Video ('{self.title}', '{self.description}', ''{self.link})"

    def to_json(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "link": self.link,
            "date": self.date
        }
