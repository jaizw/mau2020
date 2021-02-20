namespace :netkeiba do
  require 'open-uri'
  require 'nokogiri'

  task :get_umabashira, [:race_id] => :environment do |task, args|
    url = 'https://race.netkeiba.com/race/shutuba_past.html?race_id=' + args[:race_id]

    charset = nil
    html = OpenURI.open_uri(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html)
    doc.css('.HorseList').each do |horse_list|
      unless horse_list.at_css('.Waku').nil?
        umaban = horse_list.at_css('.Waku').content
      end

      horse_list.css('.Data06').each do |race_data|
        puts race_data
      end
    end
  end
end