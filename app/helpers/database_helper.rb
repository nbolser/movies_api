# frozen_string_literal: true

module DatabaseHelper
  def connect(db)
    @db = Sequel.connect("sqlite://#{db}")
  end
end
