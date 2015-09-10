
states = JSON.parse File.read Rails.root.join 'data', 'countriesToCities.json'

states.each do |country, cities|
  cities.each do |name|
    State.create country: country, name: name
  end
end

local_chapter_names = ["6th of October", "AAST  Alexandria", "AAST in Cairo",
  "GUC", "AinShams University", "Alexandria", "AUC", "Cairo University",
  "Assiut", "Mansoura", "Damietta", "Fayoum", "Menoufia", "Minya",
  "Sohag", "Suez", "Tanta", "Zagazig"]

local_chapter_names.each { |n| LocalChapter.create name: n }