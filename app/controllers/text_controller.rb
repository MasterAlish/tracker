class TextController < ApplicationController
  def markup
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {@result_markup=Wikitext::Parser.new.parse(params[:text_for_markup])}
    end
  end
end
