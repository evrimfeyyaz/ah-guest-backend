class Api::V0::UsersController < ApiController
  skip_before_action :authenticate_user_by_auth_token, only: [:create]

  rescue_from Pundit::NotAuthorizedError, with: :not_found

  def show
    load_user
    authorize @user
    render_user_json or not_found
  end

  def create
    build_user
    save_user or render_validation_error_json(@user)
  end

  private

  def load_user
    @user ||= policy_scope(User).find(params[:id])
  end

  def build_user
    @user ||= policy_scope(User).build
    @user.attributes = permitted_attributes(@user)
  end

  def save_user
    if @user.save
      response.status = :created
      render_user_json
    end
  end

  def render_user_json
    render json: @user
  end
end