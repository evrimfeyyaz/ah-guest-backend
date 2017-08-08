class Admin::ReservationImportsController < AdminController
  def new
  end

  def create
    # Adapted from https://stackoverflow.com/a/2521135
    file_data = params[:file]
    if file_data.respond_to?(:read)
      xml_contents = file_data.read
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end

    if xml_contents
      reservations = OperaArrivalsXMLImporter.xml_string_to_reservations(xml_contents)

      Reservation.transaction do
        begin
          reservations.each do |reservation|
            existing_reservation = Reservation.find_by(confirmation_code: reservation.confirmation_code)

            if existing_reservation.present?
              existing_reservation.update!(reservation.attributes.compact!)
            else
              reservation.save!
            end
          end
        rescue ActiveRecord::RecordInvalid
        end
      end

      redirect_to admin_reservations_url
    end
  end

  private

  def reservation_import_params
    params.permit[:file]
  end
end