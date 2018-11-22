class PicturesController < ApplicationController

  before_action :new_picture, only: [:new, :create]
  before_action :load_picture, except: [:index, :new, :create]
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :ensure_ownership, only: [:edit, :update, :destroy]
  before_action :write_picture, only: [:create, :update]

  layout 'home'
  
  def index
    @pictures = Picture.all

    @newest_first = Picture.newest_first
    @most_recent_pictures = Picture.created_after(1.month.ago)
    @month_old = Picture.created_before(1.month.ago)
    @pictures_2018 = Picture.pictures_created_in_year(2018)
  end

  def show
    @previous_picture = Picture.where('id > ?', @picture.id).first
    @next_picture = Picture.where('id < ?', @picture.id).last
    @last_picture = Picture.last
    @first_picture = Picture.first
  end

  def new

  end

  def create
    @picture.user_id = current_user[:id]

    if @picture.save
      redirect_to :root
    else
      render new_picture_path
    end
  end

  def edit

  end

  def update
    if @picture.save
      redirect_to picture_path(@picture)
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to :root
  end

  private

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

  def ensure_ownership
    unless current_user == @picture.user
      flash[:alert] = "Not authorized to do that!"
      if request.referer
        redirect_to request.referer
      else
        redirect_to :root
      end
    end
  end

  def new_picture
    @picture = Picture.new
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def write_picture
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
  end
end
