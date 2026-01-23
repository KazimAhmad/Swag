from config.config import db
import datetime

class Thought(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    thought = db.Column(db.String(180), nullable = False)
    more = db.Column(db.String(180), nullable = True)
    date = db.Column(db.DateTime, nullable = False, default= datetime.datetime.now(datetime.timezone.utc))

    def __repr__(self):
        return f"Thought of the day ('{self.thought}', '{self.more}')"

    @property
    def date_str(self):
        return self.date.strftime('%Y-%m-%d %H:%M:%S')

    def to_json(self):
        return {
            "id": self.id,
            "thought": self.thought,
            "more": self.more,
            "date": self.date.strftime('%Y-%m-%d %H:%M:%S')
        }
