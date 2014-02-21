class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :enforce_signin, only: [:new]
  before_action :enforce_admin_signin, only:[:destroy, :edit]
  after_action :expire_brewerylist_fragment, only: [:create, :destroy, :update]
  before_action :skip_if_cached, only: :index

  # GET /breweries
  # GET /breweries.json
  def index
    @active_breweries = Brewery.active
    @inactive_breweries = Brewery.inactive

    order = params[:order] || 'name'

    case order
      when 'name' then @active_breweries.sort_by!{ |b| b.name }
      when 'year' then @active_breweries.sort_by!{ |b| b.year }
    end
#    render :panimot
  end

  def nglist

  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # for toggling activity state
  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? 'active' : 'retired'

    redirect_to :back, notice: "Brewery activity changed to #{new_status}"
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brewery }
      else
        format.html { render action: 'new' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  private
  def skip_if_cached
    return render :index if fragment_exist?('brewerylist')
  end

  private
  def expire_brewerylist_fragment

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end

    #def authenticate
    #  admin_accounts = { "admin" => "secret", "pekka" => "beer", "arto" => "foobar", "matti" => "ittam"}
    #
    #  authenticate_or_request_with_http_basic do |username, password|
    #    # username == "admin" and password == "secret"
    #    admin_accounts[username] == password
    #  end
    #  # raise "Not yet implemented"
    #end
end
