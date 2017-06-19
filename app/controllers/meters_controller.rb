class MetersController < ApplicationController
  before_action :set_meter, only: [:edit, :update, :destroy]

  def index
    @meters = Meter.where(user_id: current_user.id)
  end

  def new
    @meter = Meter.new
  end

  def edit
  end

  def create
    @meter = Meter.new(meter_params)
    @meter.user_id = current_user.id

    respond_to do |format|
      if @meter.save
        format.html { redirect_to meters_path, notice: 'Der Zähler wurde erstellt.' }
        format.json { render json: @meter, status: :created }
      else
        format.html { render :new }
        format.json { render json: @meter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meter.update(meter_params)
        format.html { redirect_to meters_path, notice: 'Der Zähler wurde aktualisiert.' }
        format.json { render json: @meter, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @meter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meter.destroy
    respond_to do |format|
      format.html { redirect_to meters_url, notice: 'Der Zähler wurde gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    def set_meter
      @meter = Meter.find(params[:id])
    end

    def meter_params
      params.require(:meter).permit(:name, :flat_id, :expense_type, :initial_count)
    end
end
