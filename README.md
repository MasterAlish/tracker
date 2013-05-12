Issue Tracker
=========
Simplest Issue Tracker on Ruby on Rails.

Run these commands to try this out

-------------
bundle<br/>

 cp config/application.example.yml config/application.yml<br/>

setup initial app settings in config/application.yml<br/>
(for heroku run: "rake figaro:heroku")
 rake db:migrate<br/>
 rake db:seed<br/>
 rails s<br/>

Requires Ruby 2.0.0 or later to run.


##wiki text

####Shortcuts
ctrl+b, cmd+b - strong<br/>
ctrl+i, cmd+i - italic

####Short-links

\#234 - link to /ticket/234 (#234)<br/>
$[https://bitbucket/..] - link to commit in bitbucket (bb#commit)<br/>
$[https://github/..] - link to commit in github (gh#commit)<br/>

for other features look https://wincent.com/products/wikitext/doc/
