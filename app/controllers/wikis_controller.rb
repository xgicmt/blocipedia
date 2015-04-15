class WikisController < ApplicationController
  def index
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
  end

  def delete
  end
end
