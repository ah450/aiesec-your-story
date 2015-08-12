Country.all.each do |c|
  c = Country.find_country_by_name(c.first)
  c.states.to_a.each do |s|
    lat = if (s[1].keys.include?("latitude") || s[1].keys.include?(:latitude) ) then
      s[1].latitude
    else 
      c.latitude_dec 
    end
    long = if (s[1].keys.include?("longitude") || s[1].keys.include?(:longitude) ) then
      s[1].longitude
    else
        c.longitude_dec
    end
    dbState = State.create country: c.name, lat: lat.to_f, lng: long.to_f, default_name: s[1].name
    if s[1].names.is_a? Array
      s[1].names.each do |n|
        StateName.create(state: dbState, name: n) if n != s[1].name and not StateName.exists?(name: n)
      end
    end
  end
end


local_chapter_names = ["6th of October", "AAST  Alexandria", "AAST in Cairo",
  "GUC", "AinShams University", "Alexandria", "AUC", "Cairo University",
  "Assiout", "Mansoura", "Damietta", "Fayoum", "Menoufia", "Minya",
  "Sohag", "Suez", "Tanta", "Zagazig"]

local_chapter_names.each { |n| LocalChapter.create name: n }