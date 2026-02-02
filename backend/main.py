# Create
# in order tp create we need first name, last name and an email
# we need the server address the gonna run the APIs
# for now we are gonna have localhost:5000

# so we will create a create_contact endpoint for the server

# we are gonna have a requeest and the type of the request. eg: post, get, delete etc
# and the data we are gonna receive which will be a json
# response and response code as well and json as response if any

import sys
sys.path.append("../config/config.py")
sys.path.append("../requests/auth.py")
sys.path.append("../requests/about.py")
sys.path.append("../requests/book.py")
sys.path.append("../requests/movie.py")
sys.path.append("../requests/thought_of_day.py")
sys.path.append("../requests/fact.py")

from config.config import db, app
from requests import auth, about, images, book, movie, thought_of_day, fact

def requests_files():
    auth()
    about()
    images()
    book()
    movie()
    thought_of_day()
    fact()

# to run only when called this and not on the import because the import runs all the file
if __name__ == "__main__":
    with app.app_context():
        # to create all the models defined in the models in the database and only if they are not already been created
        db.create_all()
    app.run(debug=True)
    requests_files()
