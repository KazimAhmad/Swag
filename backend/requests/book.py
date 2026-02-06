from config.config import db, app
from flask import request, jsonify
from models.book import Book, BookCategory

@app.route("/books", methods = ["GET"])
def books():
    page_number = request.args.get("page", default=1, type=int)

    book_query = Book.query
    
    if "category_id" in request.args:
        category_id = request.args.get("category_id", type=int)
        movie_query = movie_query.filter(Book.category_id == category_id)

    books = book_query.order_by(
        Book.title.desc()
    ).paginate(per_page = 6, page=page_number)

    json_books = list(map(lambda book: book.to_json(), books.items))
    
    return jsonify(
        {
            "total": books.total,
            "items": json_books
        }
    ), 200

@app.route("/books/create", methods = ["POST"])
def books_create():
    data = request.get_json()

    new_title = data("title")
    new_review = data("review")
    new_book_category = data("category")
    new_rating = data("rating")
    new_link = data("link")
    new_release_year = data("release_year")

    new_book_category_name = new_book_category["name"]
    book_category = BookCategory.query.filter_by(name = new_book_category_name).first()

    if not new_title:
        return jsonify(
            {
                "error": "a valid title is required"
            }
        ), 400

    if not book_category:
        return jsonify(
            {
                "error": "a valid category is required"
            }
        ), 400
    new_book = Book(title = new_title,
                    review = new_review,
                    category = book_category,
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
    
    new_book_id = new_book.id
    return jsonify({"id": new_book_id}), 200

@app.route("/books", methods = ["DELETE"])
def delete_book():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    books = Book.query.filter(Book.id.in_(ids)).all()

    if not books:
        return jsonify({"error": "No movie found"}), 404
    
    for book in books:
        db.session.delete(book)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in books]
    }), 200


@app.route("/books/categories", methods = ["GET"])
def books_categories():
    books_cats = BookCategory.query.all()
    books_cats_to_json = list(map(lambda book: book.to_json(), books_cats))

    return jsonify(
        books_cats_to_json
    )


@app.route("/books/category/create", methods = ["POST"])
def book_category_create():
    new_name = request.json.get("name")

    same_category = BookCategory.query.filter_by(name = new_name).first()
    if same_category:
        return jsonify(
            {
                "error": "a book category with same name already exists"
            }
        ), 400
    
    if not new_name:
        return jsonify(
            {
                "error": "A valid name is required"
            }
        ), 400
    
    new_book_category = BookCategory(name = new_name)
    
    try:
        db.session.add(new_book_category)
        db.session.commit()
    
    except Exception as e:
        return jsonify(
            {
                "error": str(e) 
            }
        ), 400
    
    new_book_category_id = new_book_category.id
    return jsonify({"id": new_book_category_id}), 201


@app.route("/books/categories", methods = ["DELETE"])
def delete_books_category():
    data = request.get_json()
    ids = data.get("ids", [])

    if not ids:
        return jsonify({"error": "No IDs provided"}), 400

    books_cats = BookCategory.query.filter(BookCategory.id.in_(ids)).all()

    if not books_cats:
        return jsonify({"error": "No categories found"}), 400
    
    for cat in books_cats:
        db.session.delete(cat)

    db.session.commit()

    return jsonify({
        "deleted_ids": [t.id for t in books_cats]
    }), 200