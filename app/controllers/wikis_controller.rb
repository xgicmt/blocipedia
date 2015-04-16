class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    if @wiki.save
      redirect_to @wiki, notice: "Wiki saved"
    else
      flash[:error] = "Error creating Wiki. Try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
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
  
  def delete
  end
end
