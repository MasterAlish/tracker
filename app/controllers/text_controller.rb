class String
  def wiki_markup
    result=self.gsub(/#(\d+)/, '[/ticket/\1 #\1]')
    result=result.gsub(/\$\[([^\]]+bitbucket[^\]]+commits[^\]]+)\]/,'[\1 bb#commit]')
    result.gsub(/\$\[([^\]]+github[^\]]+commit[^\]]+)\]/,'[\1 gh#commit]')
  end
end

class TextController < ApplicationController
  def markup
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {@result_markup=params[:text_for_markup].wiki_markup.to_wikitext}
    end
  end
end
