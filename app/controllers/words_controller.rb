class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update, :destroy]
  # create a before_action that just returns the template
  #   without the layout
  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
    respond_with (@words = Word.all)
  end

  def create
    respond_with Word.create(word_params)
  end

  def show
    respond_with @word
  end

  def update
    respond_with @word.update(word_params)
  end

  def destroy
    respond_with @word.destroy
  end

  private
  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:title, :description, :complete)
  end

  def render_main_layout_if_format_html
    # check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end

end