class Api::UserAdditionsController < ApplicationController
  def show
    @userAddition = UserAddition.find(params[:id])
  end

  # POST /users
  def create
    @userAddition = UserAddition.new(user_addition_params)
    if @userAddition.save
      @latlng = Geocoder.coordinates(@userAddition.address1+@userAddition.address2+@userAddition.address3)
      # @userAddition.latitude = @userAddition.address1
      @userAddition.latitude = @latlng[0]
      @userAddition.longitude = @latlng[1]
      @userAddition.save

      render :show, status: :created
    else
      render json: @userAddition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_additions/1
  def update
    @userAddition = UserAddition.find(params[:id])
    if @userAddition.update_attributes(user_addition_params)
      # gem geocoderを介してgeocoding apiを叩く
      @latlng = Geocoder.coordinates(@userAddition.address1+@userAddition.address2+@userAddition.address3)
      @userAddition.latitude = @latlng[0]
      @userAddition.longitude = @latlng[1]
      @userAddition.save

      # statusはなんでもいいわけではなく対応するものがある
      render :show, status: :ok
    else
      render json: @userAddition.errors, status: :unprocessable_entity
    end
  end

  def search
    logger.debug(params)
    @user = User.find_by("email":params[:email])
    if @user.nil?
      render json: {continue:1, message: "no user"}
    else
      render json: {continue:0, message: "found user"}
    end
  end

  private
    def user_addition_params
      params.fetch(:userAddition, {}).permit(
          :uid, :address1, :address2, :address3
      )
    end
end
