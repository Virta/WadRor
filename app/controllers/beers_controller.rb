class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:new, :create, :edit]
  before_action :enforce_signin, only: [:new]
  before_action :enforce_admin_signin, only:[:destroy, :edit]
  after_action :expire_beerlist_fragment, only:[:create, :destroy, :update]
  before_action :skip_if_cached, only: :index

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{params[:order]}"  )
  end

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.includes(:brewery, :style, :ratings).all

    order = params[:order] || 'name'

    case order
      when 'name' then @beers.sort_by!{ |b| b.name }
      when 'brewery' then @beers.sort_by!{ |b| b.brewery }
      when 'style' then @beers.sort_by!{ |b| b.style }
    end
  end

  def list
  end

  def nglist
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    set_breweries_and_styles
  end

  # GET /beers/1/edit
  def edit
    set_breweries_and_styles
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new params.require(:beer).permit(:name, :style_id, :brewery_id)
    if @beer.save
      redirect_to @beer
    else
      set_breweries_and_styles
      render :new
    end

  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style_id, :brewery_id)
    end

  def set_breweries_and_styles
    @breweries = Brewery.all
    @styles = Style.all
  end

  def expire_beerlist_fragment
    ["name", "style", "brewery"].each{ |f| expire_fragment("beerlist-#{f}") }
  end
end
