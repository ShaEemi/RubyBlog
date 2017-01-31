class ArticlesController < ApplicationController
	http_basic_authenticate_with name: "sharon.colin@eemi.com", password: "Secret", except: [:index, :show]
	def index
		@articles = Article.all
		@page_title = "Welcome on the Ruby Blog !"
		@articles = Article.all.paginate(page: params[:page], per_page: 3)
	end
	def show
		@article = Article.find(params[:id])
	end
	def new
		@article = Article.new
		render layout: "admin"
	end
	def edit
		@article = Article.find(params[:id])
	end
	def create
		@article = Article.new(article_params)
		if @article.save
		   redirect_to @article
		   redirect_to @articles_path, notice: "Article was succcessfully created"
		else
		   render 'new', layout: "admin"
		end
	end
	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end
	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
