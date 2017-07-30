class OperaArrivalsXMLImporter
  RESERVATION_NODE_TITLE = 'G_C6'
  ROOM_NUMBER_NODE_TITLE = 'C9'
  CHECK_IN_DATE_NODE_TITLE = 'C21'
  CHECK_OUT_DATE_NODE_TITLE = 'C24'
  CONFIRMATION_CODE_NODE_TITLE = 'C57'

  def self.xml_string_to_reservations(xml_string)
    doc = Nokogiri::XML(xml_string)

    doc.css(RESERVATION_NODE_TITLE).map do |reservation_element|
      confirmation_code = reservation_element.at_css(CONFIRMATION_CODE_NODE_TITLE).text
      check_in_date_string = reservation_element.at_css(CHECK_IN_DATE_NODE_TITLE).text
      check_out_date_string = reservation_element.at_css(CHECK_OUT_DATE_NODE_TITLE).text
      room_number = reservation_element.at_css(ROOM_NUMBER_NODE_TITLE).text
      room_number = room_number.blank? ? nil : room_number.to_i

      check_in_date = Date.strptime(check_in_date_string, '%d-%b-%y')
      check_out_date = Date.strptime(check_out_date_string, '%d-%b-%y')

      Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date,
                      confirmation_code: confirmation_code, room_number: room_number)
    end
  end
end