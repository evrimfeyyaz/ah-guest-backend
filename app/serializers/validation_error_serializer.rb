class ValidationErrorSerializer < ErrorSerializer
  def error_type
    :validation
  end
end