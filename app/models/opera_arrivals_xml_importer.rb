class OperaArrivalsXMLImporter
  def self.xml_string_to_reservations(xml_string)
    doc = Nokogiri::XML(xml_string)

    doc.css('G_RESERVATION').map do |reservation_element|
      confirmation_no = reservation_element.at_css('CONFIRMATION_NO').text
      arrival = reservation_element.at_css('ARRIVAL').text
      departure = reservation_element.at_css('DEPARTURE').text
      full_name = reservation_element.at_css('FULL_NAME_NO_SHR_IND').text

      first_name, last_name = first_and_last_name_from_full_name(full_name)
      check_in_date = Date.strptime(arrival, '%d/%m/%y')
      check_out_date = Date.strptime(departure, '%d/%m/%y')

      Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date, first_name: first_name,
                      last_name: last_name, confirmation_code: confirmation_no)
    end
  end

  private

  def self.first_and_last_name_from_full_name(full_name)
    parts = full_name.split(',').map { |part| part.gsub(/\w+/, &:capitalize) }

    return parts[1], parts[0]
  end
end