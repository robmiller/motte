require "date"

module Motte
  class Citation
    include Virtus.model

    attribute :name, String
    attribute :url, String
  end

  class Case
    include Virtus.model

    attribute :name, String
    attribute :court, String
    attribute :hearing_date, Date, default: Date.today
    attribute :judgment_date, Date, default: Date.today
    attribute :url, String
    attribute :citations, Array[Motte::Citation]

    def year
      judgment_date.year
    end
  end
end
