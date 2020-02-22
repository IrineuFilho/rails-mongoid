namespace :create_federal_units_and_cities do
  desc "Create Payment Slips for Applications without Payment Slips"
  task :start => :environment do
    federal_units = JSON.parse(File.read('./lib/tasks/cities.json'))['estados']
    puts "Create Federal Units and Cities"
    federal_units.each do |federal_unit|
      federal_unit['cidades'].each { |city| City.create(name: city, federal_unit: federal_unit['nome']) }
    end
  end
end