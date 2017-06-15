class MetersController < ApplicationController
  before_action :set_meter, only: [:show, :edit, :update, :destroy]

  def index
    @meters = Meter.all
  end

  def show
  end

  def new
    @meter = Meter.new
  end

  def edit
  end

  def create
    @meter = Meter.new(meter_params)
    #@meter.user_id=current_user.id

    respond_to do |format|
      if @meter.save
        format.html { redirect_to @meter, notice: 'Meter was successfully created.' }
        format.json { render :show, status: :created, location: @meter }
      else
        format.html { render :new }
        format.json { render json: @meter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meter.update(meter_params)
        format.html { redirect_to @meter, notice: 'Meter was successfully updated.' }
        format.json { render :show, status: :ok, location: @meter }
      else
        format.html { render :edit }
        format.json { render json: @meter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meter.destroy
    respond_to do |format|
      format.html { redirect_to meters_url, notice: 'Meter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_meter
      @meter = Meter.find(params[:id])
    end

    def meter_params
      params.require(:meter).permit(:name, :flat_id, :expense_type)
    end
end
