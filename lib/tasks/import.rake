namespace :import do
  desc "Import campsites"
  task :campsites => :environment do
    importer = CampsiteImporter.new(ENV['ACTIVE_CAMPGROUND_API_KEY'])
    importer.import
  end
end
