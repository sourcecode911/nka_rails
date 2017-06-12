class CountsController < ApplicationController
  def new
    @count = Count.new
    render json: @count
  end
end
