require 'rails_helper'

describe OperaArrivalsXMLImporter do
  describe 'xml_string_to_reservations' do
    it 'converts the sample XML file properly' do
      sample_xml_file_contents = Rails.root.join('spec/support/sample_opera_arrivals_export.xml').open.read

      reservations = OperaArrivalsXMLImporter.xml_string_to_reservations(sample_xml_file_contents)

      expect(reservations[0].check_in_date).to eq(Date.parse('2017-06-25'))
      expect(reservations[0].check_out_date).to eq(Date.parse('2017-08-01'))
      expect(reservations[0].room_number).to eq('403')
      expect(reservations[0].confirmation_code).to eq('234112')

      expect(reservations[1].check_in_date).to eq(Date.parse('2017-06-25'))
      expect(reservations[1].check_out_date).to eq(Date.parse('2017-08-01'))
      expect(reservations[1].room_number).to eq('407')
      expect(reservations[1].confirmation_code).to eq('234111')

      expect(reservations[2].check_in_date).to eq(Date.parse('2017-07-15'))
      expect(reservations[2].check_out_date).to eq(Date.parse('2017-08-29'))
      expect(reservations[2].room_number).to eq('409')
      expect(reservations[2].confirmation_code).to eq('234217')

      expect(reservations[3].check_in_date).to eq(Date.parse('2017-07-22'))
      expect(reservations[3].check_out_date).to eq(Date.parse('2017-07-27'))
      expect(reservations[3].room_number).to eq(nil)
      expect(reservations[3].confirmation_code).to eq('237164')
    end
  end
end