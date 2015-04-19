class WikisController < ApplicationController
  def index
    if !current_user || current_user.role == 'standard'
      @wikis = Wiki.where(private: false).order('created_at DESC')
    else current_user.role == 'admin' || 'premium'
      @wikis = Wiki.order('created_at DESC').all
    end
  end

  def show
      @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    
    @wiki = current_user.wikis.new(params.require(:wiki).permit(:title, :body, :private, :user_id))
    if @wiki.save
      redirect_to @wiki, notice: "Wiki saved"
    else
      flash[:error] = "Error creating Wiki. Try again."
      render :new
    end

  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  def update
    @wiki = Wiki.find(params[:id])
      if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
        redirect_to @wiki
      else
        flash[:error] = "Error saving Wiki, try again"
        render :show
      end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "The wiki was successfully deleted"
      redirect_to wikis_path
    else
      flash[:error] = "Something went wrong while deleting the wiki, please try again"
      render :show
    end
  end


end
