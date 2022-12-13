class SearchController < ApplicationController
  def index
    @q = Post.ransack(params[:q])

    @posts_by_three = []
    @posts = @q.result(distinct: true)

    if @posts.length < 3
      @posts.each_slice(1) { |column| @posts_by_three.push(column) }
    elsif (@posts.length % 3).zero?
      @posts.each_slice(@posts.length / 3) { |column| @posts_by_three.push(column) }
    else
      @posts.each_slice(@posts.length / 3) { |column| @posts_by_three.push(column) }
      @posts_by_three.last.each_with_index { |el, index| @posts_by_three[index].push(el) }
      @posts_by_three.pop
    end
    @posts_by_three
  end
end
