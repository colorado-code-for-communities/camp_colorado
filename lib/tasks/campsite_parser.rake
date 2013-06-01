namespace :parse do
  task :campsites => :environment do
    campsite_importer = CampsiteImporter.new(ENV['CAMPSITE_API_KEY'])
    campsite_importer.import
  end
end
