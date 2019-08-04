Dir.glob(File.join(Rails.root, 'db', 'seed', '*.rb')).each do |file|
  desc "Load the seed data from db/seed/#{File.basename(file)}."
  task "db:seed:#{File.basename(file).gsub(/\..+$/, '')}" => :environment do
    load(file)
  end
end
