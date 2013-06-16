class String
  def wiki_markup
    result=self.gsub(/#(\d+)/, '[/tickets/\1 #\1]')
    result=result.gsub(/\$\[([^\]]+bitbucket[^\]]+commits[^\]]+)\]/,'[\1 bb#commit]')
    result.gsub(/\$\[([^\]]+github[^\]]+commit[^\]]+)\]/,'[\1 gh#commit]')
  end
end

class NilClass
  def wiki_markup
    ''
  end
end

class TextController < ApplicationController
  def markup
    render inline: (params[:text_for_markup]||'').wiki_markup.to_wikitext
  end
end
