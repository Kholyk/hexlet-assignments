require 'csv'

namespace :hexlet do
  desc 'Imports users from CSV file defined as an argument'
  task :import_users, [:file_path] => :environment do |task, args|
    csv_file_path = args[:file_path]

    _, * array_of_users = CSV.read(csv_file_path)

    pp array_of_users.count

    array_of_users.each do |user|
      first_name, last_name, birthday, email = user
      user = User.create(first_name: first_name, last_name: last_name, birthday: birthday, email: email)
      pp User.count
      pp user
    end
  end

end
