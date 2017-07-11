class Admin::ReservationImportsController < Admin::BaseController
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
          reservations.each(&:save!)
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