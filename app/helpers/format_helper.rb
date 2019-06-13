# frozen_string_literal: true

module FormatHelper
  def number_to_currency(num)
    "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,').concat('.00')}"
  end
end
