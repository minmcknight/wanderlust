class TrailUsersController < ApplicationController
  before_action :set_trail_user, only: [:show, :edit, :update, :destroy]

  # GET /trail_users
  # GET /trail_users.json
  def index
    @trail_users = TrailUser.all
  end

  # GET /trail_users/1
  # GET /trail_users/1.json
  def show
  end

  # GET /trail_users/new
  def new
    @trail_user = TrailUser.new
    @trail_user.trail_id = params[:trail_id]
  end

  # GET /trail_users/1/edit
  def edit
  end

  # POST /trail_users
  # POST /trail_users.json
  def create
    @trail_user = TrailUser.new(trail_user_params)
    @trail_user.user_id = current_user.id
    respond_to do |format|
      if @trail_user.save
        format.html { redirect_to @trail_user.trail, notice: 'Favorite was successfully created.' }
        format.json { render :show, status: :created, location: @trail_user }
      else
        format.html { render :new }
        format.json { render json: @trail_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trail_users/1
  # PATCH/PUT /trail_users/1.json
  def update
    respond_to do |format|
      if @trail_user.update(trail_user_params)
        format.html { redirect_to @trail_user, notice: 'Trail user was successfully updated.' }
        format.json { render :show, status: :ok, location: @trail_user }
      else
        format.html { render :edit }
        format.json { render json: @trail_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trail_users/1
  # DELETE /trail_users/1.json
  def destroy
    @trail_user.destroy
    respond_to do |format|
      format.html { redirect_to trail_users_url, notice: 'Trail user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail_user
      @trail_user = TrailUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trail_user_params
      params.require(:trail_user).permit(:trail_id, :comment, :rating )
    end
end
