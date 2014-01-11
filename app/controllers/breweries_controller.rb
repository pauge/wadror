class BreweriesController < ApplicationController

  before_filter :ensure_that_signed_in, :except => [:index, :show]
	before_filter :is_admin, only: :destroy

  # GET /breweries
  # GET /breweries.json
  def index
    @breweries = Brewery.all.sort_by{ |b| b.send(params[:order] || 'name') }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @breweries }
    end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/new
  # GET /breweries/new.json
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit
    @brewery = Brewery.find(params[:id])
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(params[:brewery])

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render json: @brewery, status: :created, location: @brewery }
      else
        format.html { render action: "new" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.json
  def update
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      if @brewery.update_attributes(params[:brewery])
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery = Brewery.find(params[:id])
		Beer.all.each {|b| b.delete if b.brewery == (@brewery) }
    @brewery.destroy

    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end


  private

  def authenticate
	accounts = {"admin" => "secret", "arto" => "otra", "ismo" => "seppo"}

	authenticate_or_request_with_http_basic do |username, password|
		accounts[username] == password
	end
  end
end
