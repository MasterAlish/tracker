class TextController < ApplicationController
  def markup
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {@result_markup=params[:text_for_markup].to_wikitext}
    end
  end
end
