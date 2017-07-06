class ResidentsController < ApplicationController
  before_action :set_resident, only: [:edit, :update, :destroy]

  # GET /residents
  # GET /residents.json
  def index
    @residents = Resident.where(user_id: current_user.id)
  end

  # GET /residents/new
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents
  # POST /residents.json
  def create
    @resident = Resident.new(resident_params)
    @resident.user_id = current_user.id

    respond_to do |format|
      if @resident.save
        format.html { redirect_to residents_path, notice: 'Bewohner wurde erstellt.' }
        format.json { render json: @resident, status: :created }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to residents_path, notice: 'Bewohner wurde aktualisiert.' }
        format.json { render json: @resident, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  def destroy
    @resident.destroy
    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Der Bewohner wurde entfernt.' }
      format.json { head :no_content }
    end
  end

  private
    def set_resident
      @resident = Resident.find(params[:id])
    end

    def resident_params
      params.require(:resident).permit(:first_name, :last_name, :move_in, :move_out, :flat_id, :persons, :street, :plz, :location, :email)
    end
end
