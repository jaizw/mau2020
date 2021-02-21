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

    umabashira = []
    doc = Nokogiri::HTML.parse(html)
    doc.css('.HorseList').each do |horse_list|
      if horse_list.at_css('.Waku').nil?
        next
      else
        umaban = horse_list.at_css('.Waku').content
      end

      race_data = []
      horse_list.css('.Data06').each do |data|
        contents = data.content.gsub(")","(").split('(')
        race_data.push(contents[0].strip) unless contents.nil?
      end
      uma_hash = {umaban => race_data}
      umabashira.push(uma_hash)
    end

    puts umabashira
  end
end