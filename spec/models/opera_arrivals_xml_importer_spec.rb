require 'rails_helper'

describe OperaArrivalsXMLImporter do
  describe 'xml_string_to_reservations' do
    it 'converts the sample XML file properly' do
      sample_xml_file_contents = Rails.root.join('spec/support/sample_opera_arrivals_export.xml').open.read

      reservations = OperaArrivalsXMLImporter.xml_string_to_reservations(sample_xml_file_contents)

      expect(reservations[0].check_in_date).to eq(Date.parse('2017-05-01'))
      expect(reservations[0].check_out_date).to eq(Date.parse('2017-05-03'))
      expect(reservations[0].room_number).to eq(nil)
      expect(reservations[0].confirmation_code).to eq('4001321')
      expect(reservations[0].first_name).to eq('Mostafa')
      expect(reservations[0].last_name).to eq('Al Abdul')

      expect(reservations[1].check_in_date).to eq(Date.parse('2017-05-01'))
      expect(reservations[1].check_out_date).to eq(Date.parse('2017-05-03'))
      expect(reservations[1].room_number).to eq(nil)
      expect(reservations[1].confirmation_code).to eq('40006654')
      expect(reservations[1].first_name).to eq('Jeremy John')
      expect(reservations[1].last_name).to eq('Conner')

      expect(reservations[2].check_in_date).to eq(Date.parse('2017-05-02'))
      expect(reservations[2].check_out_date).to eq(Date.parse('2017-05-06'))
      expect(reservations[2].room_number).to eq(nil)
      expect(reservations[2].confirmation_code).to eq('4002623')
      expect(reservations[2].first_name).to eq('Ali')
      expect(reservations[2].last_name).to eq('Ababwa')

      expect(reservations[3].check_in_date).to eq(Date.parse('2017-05-02'))
      expect(reservations[3].check_out_date).to eq(Date.parse('2017-05-04'))
      expect(reservations[3].room_number).to eq(nil)
      expect(reservations[3].confirmation_code).to eq('4023427')
      expect(reservations[3].first_name).to eq('Mohammed')
      expect(reservations[3].last_name).to eq('Ali')
    end
  end

  context 'when full name is all caps' do
    it 'properly capitalizes the name' do
      sample_xml = '
      <G_RESERVATION>
          <CONFIRMATION_NO>4023427</CONFIRMATION_NO>
          <ARRIVAL>02/05/17</ARRIVAL>
          <FULL_NAME_NO_SHR_IND>ABABWA,ALI,YE</FULL_NAME_NO_SHR_IND>
          <DEPARTURE>04/05/17</DEPARTURE>
        </G_RESERVATION>
      '

      reservations = OperaArrivalsXMLImporter.xml_string_to_reservations(sample_xml)

      expect(reservations.first.first_name).to eq('Ali')
      expect(reservations.first.last_name).to eq('Ababwa')
    end
  end

  context 'when a name has multiple words and inconsistent capitalization' do
    it 'properly capitalizes each word in the name' do
      sample_xml = '
      <G_RESERVATION>
          <CONFIRMATION_NO>4023427</CONFIRMATION_NO>
          <ARRIVAL>02/05/17</ARRIVAL>
          <FULL_NAME_NO_SHR_IND>AL AbAbwA,ALI aladdin,YE</FULL_NAME_NO_SHR_IND>
          <DEPARTURE>04/05/17</DEPARTURE>
        </G_RESERVATION>
      '

      reservations = OperaArrivalsXMLImporter.xml_string_to_reservations(sample_xml)

      expect(reservations.first.first_name).to eq('Ali Aladdin')
      expect(reservations.first.last_name).to eq('Al Ababwa')
    end
  end
end