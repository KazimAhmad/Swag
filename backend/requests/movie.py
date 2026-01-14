from config.config import db, app
from flask import request, jsonify
from models.movie import Movie, MovieCategory

@app.route("movies", methods = ["GET"])
def movies():
    page_number = request.args.get("page", default=1, type=int)
    category = request.args.get("category", default="All", type=str)

    movies = Movie.query.filter_by(
        Movie.category == category
    ).paginate(per_page = 10, page=page_number).limit(3).all()

    json_movies = list(map(lambda movie: movie.to_json, movies))

    return jsonify(
        {
            "movies": json_movies
        }
    )

@app.route("movies/create", methods = ["POST"])
def movies_create():
    new_title = request.json.get("title")
    new_review = request.json.get("review")
    new_category = request.json.get("category")
    new_rating = request.json.get("rating")
    new_imdb_link = request.json.get("imdb_link")
    new_release_year = request.json.get("release_year")

    if not new_title:
        return jsonify(
            {
                "error": "a valid title is required"
            }
        ), 400
    new_category_enum = MovieCategory(new_category)
    if not new_category_enum:
        return jsonify(
            {
                "error": "a valid category is required"
            }
        ), 400
    new_movie = Movie(title = new_title,
                      review = new_review,
                      category = new_category_enum,
                      rating = new_rating,
                      imdb_link = new_imdb_link,
                      release_year = new_release_year)
    
    try:
        db.session.add(new_movie)
        db.session.commit()

    except Exception as e:
        return jsonify(
            {
                "error": str(e)
            }
        ), 400
    
    return jsonify(
        {
            "message": "movie created successfully"
        }
    ), 200
