from config.config import db, app
from flask import request, jsonify
from models.book import Book, BookCategory

@app.route("/books", methods = ["GET"])
def books():
    page_number = request.args.get("page", default=1, type=int)
    category = request.args.get("category", default="All", type=str)

    books = Book.query.filter_by(
        Book.category == category
    ).paginate(per_page = 10, page=page_number).limit(3).all()

    json_books = list(map(lambda book: book.to_json, books))

    return jsonify(
        {
            "books": json_books
        }
    )

@app.route("/books/create", methods = ["POST"])
def books_create():
    new_title = request.json.get("title")
    new_review = request.json.get("review")
    new_category = request.json.get("category")
    new_rating = request.json.get("rating")
    new_link = request.json.get("link")
    new_release_year = request.json.get("release_year")

    if not new_title:
        return jsonify(
            {
                "error": "a valid title is required"
            }
        ), 400
    new_category_enum = BookCategory(new_category)
    if not new_category_enum:
        return jsonify(
            {
                "error": "a valid category is required"
            }
        ), 400
    new_book = Book(title = new_title,
                    review = new_review,
                    category = new_category_enum,
                    rating = new_rating,
                    imdb_link = new_link,
                    release_year = new_release_year)
    
    try:
        db.session.add(new_book)
        db.session.commit()

    except Exception as e:
        return jsonify(
            {
                "error": str(e)
            }
        ), 400
    
    return jsonify(
        {
            "message": "book created successfully"
        }
    ), 200
