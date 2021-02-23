namespace :sanspo do
  require 'open-uri'
  require 'nokogiri'

  task :get_umabashira, [:race_id] => :environment do |task, args|
    url = 'https://deep.race.sanspo.com/race/' + args[:race_id] + '/'

    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    agent.get(url) do |page|
      doc = page.form_with(name: 'site_login') do |form|
        form.userName = 'ログインID'
        form.password = 'パスワード'
      end.submit

      doc = Nokogiri::HTML(doc.content.toutf8)
    end
  end
end
