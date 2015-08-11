# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Country.all.each do |c|
  c.states.each do |s|
    dbState = State.create country: c.name, lat: c.latitude, lng: c.longitude, default_name: s.name
    s.names.each { |n| StateName.create state: dbState, name: n }
  end
end


local_chapter_names = []

local_chapter_names.each { |n| LocalChapter.create name: n}