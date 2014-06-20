#!/usr/bin/env ruby

require "open-uri"
require "nokogiri"
require "sqlite3"

root = "http://wiki.homebrewersassociation.org"
recipes = {};

#(2005..2013).each do |year|
%w(2005).each do |year|
  doc = Nokogiri::HTML(open("#{root}/#{year}NHCGoldMedalRecipes")) do |config|
    config.noblanks
  end

  recipes["#{year}"] = []
  doc.css('p > a').each do |link|
    next if link.children.empty? # Fucking hidden links
    next if link['href'] =~ /(^\/_Login|^http)/
    recipes["#{year}"] << link['href']
  end

end

cats = [
  :BeerBOS,
  :MeadBOS,
  :CiderBOS,
  :LightLager,
  :Pilsner,
  :EuroLager,
  :DarkLager,
  :Bock,
  :LightHybrid,
  :AmberHybrid,
  :EPA,
  :Irish,
  :American,
  :EBA,
  :Porter,
  :Stout,
  :IPA,
  :Wheat,
  :French,
  :Sour,
  :Belgian,
  :Strong,
  :Old,
  :Fruit,
  :Spice,
  :Smoke,
  :Special,
  :Mead,
  :Mel,
  :OtherMead,
  :Cider
]

not_beer = [
  :BeerBOS,
  :MeadBOS,
  :CiderBOS,
  :Mead,
  :Mel,
  :OtherMead,
  :Cider,
  :New,
  :Special
]

db = SQLite3::Database.new "./nhc_analysis"

recipes.keys.each do |y|
  recipes[y].each_with_index do |recipe, i|
    next if i > cats.length
    next if not_beer.include? cats[i]

    if recipe =~ /^\//
      addr = "#{root}#{recipe}"
    else
      addr = "#{root}/#{recipe}"
    end
    rec = Nokogiri::HTML(open(addr)) do |config|
      config.noblanks
    end

    puts "#{i}. #{cats[i]} (#{addr})" # category

    rec.css('#column2').each do |thing|
      begin
        lines = thing.content.split(/\n/)
        lines.each do |line|
          if line =~ /(?:lb|oz)s?/i
            if line =~ /sugar/i
              next if line =~ /prim/i #Skip the priming sugar

              sugar_array = line.strip.scan(/\((.*)\)\s+(.*)/)
              sugars = sugar_array[0];
              sugar_amount = sugars[0].split(/ /)

              puts "    SUGAR: #{sugar_amount[0]}" # Amount
              puts "    SUGAR: #{sugar_amount[1]}" # Unit
              puts "    SUGAR: #{sugars[1]}"       # Type
              #sugar_exists = db.execute("SELECT EXISTS(SELECT 1 FROM sugars WHERE sugar = ? LIMIT 1)", sugar);
              next
            end
            if line =~ /malt/i
              malt_array = line.strip.scan(/\((.*)\)\s+(.*)/)
              malts = malt_array[0];
              malt_amount = malts[0].split(/ /)

              puts "    MALT: #{malt_amount[0]}" # Amount
              puts "    MALT: #{malt_amount[1]}" # Unit
              puts "    MALT: #{malts[1]}"       # Type
            end
            if line =~ /hops?/i
              hop_array = line.strip.scan(/\((.*)\)\s+(.*),.*\((.*)\)/)
              hops = hop_array[0];
              hop_amount = hops[0].split(/ /)

              puts "    HOPS: #{hop_amount[0]}" # Amount
              puts "    HOPS: #{hop_amount[1]}" # Unit
              puts "    HOPS: #{hops[1]}"       # Name
              puts "    HOPS: #{hops[2]}"  # Time
            end
            puts "    HOPS: #{line.strip}" if line =~ /hops/i
          end
          puts "    YEAST: #{line.strip}" if line =~ /yeast/i
        end
      rescue
        puts 'NOPE.'
      end
    end
  end
end
