namespace :netkeiba do
  require 'kconv'
  require 'open-uri'
  require 'nokogiri'

  task :get_umabashira, [:race_id] => :environment do |task, args|
    uri = 'https://race.netkeiba.com/race/shutuba_past.html?race_id=' + args[:race_id]

    page = URI.parse(uri).read
    charset = page.charset

    umabashira = []
    doc = Nokogiri::HTML(page.toutf8, nil, 'utf-8')
    doc.css('.HorseList').each do |horse_list|
      if horse_list.at_css('.Waku').nil?
        next
      else
        umaban = horse_list.at_css('.Waku').content
      end

      jockey = horse_list.at_css('.Jockey a').content

      race_data_03 = []
      horse_list.css('.Data03').each do |data|
        contents = data.content
        puts contents

        race_data_03.push(contents[0].strip) unless contents.nil?
      end

      race_data_06 = []
      horse_list.css('.Data06').each do |data|
        contents = data.content.gsub(")","(").split('(')
        race_data_06.push(contents[0].strip) unless contents.nil?
      end
      
      uma_hash = {umaban => {'jockey' => jockey, 'race_data_03' => $race_data_03, 'race_data_06' => race_data_06}}
      umabashira.push(uma_hash)
    end

    #puts umabashira
  end
end