namespace :import do
  task :campsites => :environment do
    CampsiteImporter.new(ENV['CAMPSITE_API_KEY']).import
  end
end
