class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ destroy quote]
  before_action :authenticate_user!,only: %i[quote]#Regla que provoca que solo los usuarios autentificados pueden retweetear

  # GET /tweets or /tweets.json
  def index
    #Busqueda Parcial
    if params[:q]
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.eager_load(:likes).order(created_at: :desc).page params[:page] #Ordenando la vista dejando el ultimo creado en primera posicion
    end
    @tweet = Tweet.new #Accion para crear un tweet
    @user_likes = Like.eager_load(:user, :tweet).where(user: current_user).pluck(:tweet_id)
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    @tweet = Tweet.find(params[:id]) #Encontramos el tweet segun el ID
    @tweet_likes = @tweet.likes #Creamos la variable para mostrar los usuarios que le dieron el like
  end

  def quote
    @quote = Tweet.new #Creando una nueva instancia de un nuevo tweet
    @quote.content = @tweet.content #Se carga el contenido del nuevo retweet
    @quote.user_id = current_user.id #Se carga el usuario actual
    @quote.tweet_id = @tweet.id #Se carga el id del tweet al retweet
    @quote.created_at = DateTime.now #Se carga la nueva fecha de creacion para el retweet ya que no debe tener la misma que el tweet original
    @quote.updated_at = DateTime.now #Se carga la nueva fecha de actualizacion para el retweet ya que no debe tener la misma que el tweet original
    respond_to do |format| #Y por ultimo se direcciona al root cuando se guarde
      if @quote.save
        format.html { redirect_to root_path, notice: "Tu Retweet fue creado con exito!" }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tu Tweet se ha publicado con exito!" }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :total_tweet, :retweet)
    end
end
