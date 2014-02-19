class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :enforce_signin, except: [:index, :show]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # confirmation toggling
  def toggle_confirmation
    membership = Membership.find params[:id]
    if membership.beer_club.members(true).map(&:user).include?(current_user)
      membership.update_attribute(:confirmed, true)
      redirect_to :back, notice: "Membership of #{membership.user.username} confirmed."
    else
      redirect_to :back, notice: "Only a confirmed member of this club can confirm memberships."
    end

  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    if current_user
      @membership = Membership.new params.require(:membership).permit(:beer_club_id)
      @membership.confirmed=false

      if current_user.memberships.find_by(beer_club_id:(@membership.beer_club_id))
        @beer_clubs = BeerClub.all
        redirect_to :back, notice: "You are already a member of that club"
      elsif @membership.save
        current_user.memberships << @membership
        redirect_to beer_club_path(@membership.beer_club_id), notice: "Welcome to #{@membership.beer_club.name}! An elder must still confirm your membership."
      else
        @beer_clubs = BeerClub.all
        render :new
      end

    end


    #@membership = Membership.new(membership_params)
    #
    #respond_to do |format|
    #  if @membership.save
    #    format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @membership }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @membership.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    redirect_to user_path current_user
    #respond_to do |format|
    #  format.html { redirect_to memberships_url }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id)
    end
end
