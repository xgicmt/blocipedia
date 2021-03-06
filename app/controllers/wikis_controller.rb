class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
    @wikis= @wikis.paginate(page: params[:page], per_page: 10)
    @background_class = 'wikiIndexBack'
  end

  def show
      @wiki = Wiki.find(params[:id])
      @users = User.all

        if @wiki.modified_by == nil
          @last_modified = @wiki.user.name
        else
          @last_modified = User.find(@wiki.modified_by).name
        end

      @collaborators = Collaborator.where(:wiki_id => @wiki).all
      @background_class = 'wikiShowBack'
  end

  def new
    @wiki = Wiki.new
    @background_class = 'wikiNewBack'
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
      if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :modified_by, :private))
        flash[:notice] = "Your contribution has been documented."
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


        def add_collaborator
          @wiki = Wiki.find(params[:wiki_id])
         if @wiki.update_attributes(params.require(:wiki).permit(:user_ids => []))
          #@collaborator = Collaborator.new(params.require(:collaborators).permit(:wiki_id,:user_ids => []))
          #@collaborator = Collaborator.new(wiki_id: @wiki, user_id: params[:user_ids])
          #@collaborator = @wiki.collaborators.build(params.require(:collaborator).permit(:wiki_id, :user_id => [:user_ids]))

        
           flash[:notice] = "Collaborator Modified"
           redirect_to @wiki
          else
            flash[:error] = "Error, probably my fault, try again!"
          end

        end

end
