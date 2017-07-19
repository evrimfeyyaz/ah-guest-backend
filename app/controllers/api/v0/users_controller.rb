class Api::V0::UsersController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:create]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    load_user
    render_user_json or not_found
  end

  def create
    build_user
    save_user or render_validation_error_json
  end

  private

  def load_user
    @user ||= user_scope.find(params[:id])
  end

  def build_user
    @user ||= user_scope.build
    @user.attributes = user_params
  end

  def save_user
    http_status = @user.persisted? ? :ok : :created

    if @user.save
      render json: @user, status: http_status
    end
  end

  def render_user_json
    if @user == current_user
      render json: @user
    end
  end

  def not_found
    return head :not_found
  end

  def render_validation_error_json
    render json: @user, status: :unprocessable_entity, serializer: ValidationErrorSerializer
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user_scope
    User.all
  end
end