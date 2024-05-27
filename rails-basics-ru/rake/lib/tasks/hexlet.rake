# frozen_string_literals: true

require 'csv'

namespace :hexlet do
  desc 'Imports users from CSV file defined as an argument'
  task :import_users, [:file_path] => :environment do |_task, args|
    csv_file_path = args[:file_path]

    _, * array_of_users = CSV.read(csv_file_path)

    array_of_users.each do |user|
      first_name, last_name, birthday, email = user

      User.create(
        first_name:,
        last_name:,
        birthday: Date.strptime(birthday, '%m/%d/%Y'),
        email:
      )
    end
  end

end
