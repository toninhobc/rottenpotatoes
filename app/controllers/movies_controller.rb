class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @all_ratings = Movie.all_ratings

    # 1. Verificar se é necessário redirecionar com base na sessão
    # Se a requisição NÃO trouxe parâmetros de sort/ratings,
    # mas eles existem na sessão:
    if params[:sort].nil? && params[:ratings].nil? &&
      (session[:sort].present? || session[:ratings].present?)
      flash.keep
      redirect_to movies_path(
        sort: session[:sort],
        ratings: session[:ratings]
      ) and return
    end

    # 2. Capturar ordenação (dos parâmetros ou da sessão)
    allowed_sorts = %w[title release_date]
    sort_param = params[:sort] || session[:sort]
    @sort = sort_param if allowed_sorts.include?(sort_param)

    # 3. Capturar classificações (dos parâmetros ou da sessão)
    if params[:ratings].present?
      @selected_ratings = params[:ratings].keys
    elsif session[:ratings].present?
      @selected_ratings = session[:ratings].is_a?(Hash) ?
        session[:ratings].keys :
        session[:ratings]
    else
      @selected_ratings = @all_ratings
    end

    # 4. Salvar o estado atual na sessão para requisições futuras
    session[:sort] = @sort
    session[:ratings] = params[:ratings] ||
                        Hash[@selected_ratings.map { |r| [r, "1"] }]

    # 5. Buscar e ordenar filmes no banco de dados
    @movies = Movie.where(rating: @selected_ratings)
    @movies = @movies.order(@sort) if @sort.present?
end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @movie.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, notice: "Movie was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :rating, :description, :release_date ])
    end
end
