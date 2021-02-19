namespace :netkeiba do
  require 'open-uri'
  require 'nokogiri'

  task get_umabashira: :environment do
    url = "https://www.yahoo.co.jp/"

    charset = nil
    html = OpenURI.open_uri(url) do |f|
      charset = f.charset
      f.read
    end

    puts html
  end
end