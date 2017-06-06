class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

  def landing
    @how_many_ad = Advertisement.count
    @how_many_com = Comment.count
  end

  # GET /advertisements
  # GET /advertisements.json
  # checking what's the user's role to see if they can have access to unpublished stuff
  def index
    @how_many_ad = Advertisement.count
    if @current_user != nil && @current_user.role == 'admin'
      @advertisements = Advertisement.all
    else
      @advertisements = Advertisement.where(published: true)
    end
  end

  # GET /advertisements/1
  # GET /advertisements/1.json
  def show
    # checking if the person who accesses the unpublished advertisements is an admin
    @advertiser = User.find(@advertisement.user_id)
    if @advertisement.published == false && session[:user_id] == nil || @advertisement.published == false && @current_user.role != "admin"
      flash[:not_admin] = "Vous ne faites pas partie de l'équipe d'administration !"
      return redirect_to "/advertisements"
    else
    end
    # part of the show action that is about comments
    @comment = Comment.new
    @comments = Comment.where(advertisement_id: @advertisement.id)
  end

  # GET /advertisements/new
  def new
    if defined? @current_user.name
      @advertisement = Advertisement.new
    else
      flash[:need_to_connect] = "Il faut se connecter !"
      return redirect_to "/users/login"
    end
  end

  # GET /advertisements/1/edit
  def edit
    if session[:user_id] == nil || @current_user.role != 'admin'
      flash[:not_admin] = "Vous ne faites pas partie de l'équipe d'administration !"
      redirect_to "/advertisements"
    else
    end
  end

  # POST /advertisements
  # POST /advertisements.json
  def create
    if advertisement_params[:published] == nil
      @advertisement = Advertisement.new(advertisement_params.merge!(published: false, user_id: session[:user_id]))
    else
      @advertisement = Advertisement.new(advertisement_params)
    end

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to advertisements_path, notice: "L'annonce a bien été créé." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /advertisements/1
  # PATCH/PUT /advertisements/1.json
  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to @advertisement, notice: "L'annonce a été modifiée avec succès !"}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /advertisements/1
  # DELETE /advertisements/1.json
  def destroy
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to advertisements_url, notice: 'Advertisement was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertisement_params
      params.require(:advertisement).permit(:title, :price, :content, :user_id, :published)
    end
end
