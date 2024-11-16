class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    m = Movie.new
    m.title = params.fetch("user_input_movie_title")
    m.year = params.fetch("user_input_movie_year")
    m.duration = params.fetch("user_input_movie_duration")
    m.description = params.fetch("user_input_movie_desc")
    m.image = params.fetch("user_input_movie_image")
    m.director_id = params.fetch("user_input_movie_director_id")
    m.save

    redirect_to("/movies")
  end 

  def del
    movie_del_id = params.fetch("path_id")

    matching_records = Movie.where({ :id => movie_del_id}).at(0)

    matching_records.destroy

    redirect_to("/movies")
  end 

  def update
    movie_update_id = params.fetch("path_id")

    m = Movie.where({ :id => movie_update_id}).at(0)
    m.title = params.fetch("user_input_movie_title")
    m.year = params.fetch("user_input_movie_year")
    m.duration = params.fetch("user_input_movie_duration")
    m.description = params.fetch("user_input_movie_desc")
    m.image = params.fetch("user_input_movie_image")
    m.director_id = params.fetch("user_input_movie_director_id")
    m.save
    redirect_to("/movies/#{m.id}")
  end 
end
