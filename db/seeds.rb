Dir.glob(File.join(Rails.root, 'db', 'seed', '*.rb')).each do |file|
  load(file)
end
