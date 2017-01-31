class CommentsController < ApplicationController
	http_basic_authenticate_with name: "sharon.colin@eemi.com", password: "Secret", only: :destroy
	def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end
 	def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comments was successfully deleted"
    redirect_to article_path(@article)
  end
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
