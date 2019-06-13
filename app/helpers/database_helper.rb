# frozen_string_literal: true

module DatabaseHelper
  def connect(db)
    binding.pry
    @db = Sequel.connect("sqlite://#{db}")
  end
end
