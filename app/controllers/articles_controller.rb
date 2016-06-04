class ArticlesController < ApplicationController
   
   #before anything else, call set_article
   before_action :set_article, only: [:edit, :update, :show, :destroy]
   before_action :require_user, except: [:index, :show]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def index
      @articles = Article.paginate(page:  params[:page], per_page: 5)
   end
   
   def new
      @article = Article.new
   end
   
   def edit
      
   end
   
   def create
      #render plain: params[:article].inspect
      @article = Article.new(article_params)
      @article.user = current_user
      if @article.save
        #do something
        flash[:success] = "Article was successfully created!"
        redirect_to article_path(@article)
      else
        render 'new' #validation failed, render new template to create article
      end
      
   end
   
   def update
      set_article
      if @article.update(article_params)
         flash[:success] = "Article was successfully updated"
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end
   
   def show
      set_article
   end
   
   def destroy
      set_article  #call set_article method from below
      @article.destroy
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
   end
   
   private 
   
      def set_article
         @article = Article.find(params[:id])
      end
      
      def article_params
         #top-level key article, permit title and description as input values
         params.require(:article).permit(:title, :description, category_ids: [])
      end
      
      def require_same_user
         if current_user != @article.user and !current_user.admin?
            flash[:danger] = "You can only edit or delete your own articles"
            redirect_to root_path
         end
      end
   
end