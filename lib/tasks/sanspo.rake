namespace :sanspo do
  require 'open-uri'
  require 'nokogiri'

  task :get_umabashira, [:race_id] => :environment do |task, args|
    url = 'https://deep.race.sanspo.com/race/' + args[:race_id] + '/'
    
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    
    page = agent.get(url)
    form = page.forms[0]

    puts form.to_yaml

    form.field_with(name: 'userName').value = ''
    form.field_with(name: 'password').value = ''
    form.field_with(name: 'page').value = ''
    
    logined_page = agent.submit(form)
    puts logined_page.content.toutf8
  end
end
