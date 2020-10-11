require 'will_paginate/array'
require "cpf_cnpj"

class BusTravelsController < ApplicationController
  def index
    if current_user.admin? || current_user.police?
      @bus_travels = BusTravel.by_departure.includes(
        travel_line: :company, passenger_trips: {passenger: :alerts}
        ).where('departure_on >= ?', Date.today).sort_by(&:alerts).reverse.paginate(
        :page => params[:page], :per_page => 10)
    else
      company = Company.where(user_id: current_user.id)
      travel_lines = TravelLine.where(company_id: company.ids)
      @bus_travels = BusTravel.where(travel_line_id: travel_lines.ids).where(
        'departure_on >= ?', Date.today).paginate(:page => params[:page],
        :per_page => 10)
    end
  end

  def show
    @bus_travel = BusTravel.find(params[:id])
    @passenger_trips = @bus_travel.passenger_trips.order('seat ASC').paginate(
        :page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name"   # Excluding ".pdf" extension.
      end
    end
  end


  def new
    if current_user.admin?
      @bus_travel = BusTravel.new
    else
      forbidden
    end
  end

  def create
    if current_user.admin?
      @bus_travel = BusTravel.new(bus_travel_params)
      if @bus_travel.save
        redirect_to bus_travels_path, notice: "A viagem foi cadastrada com sucesso!"
      else
        render :new
      end
    else
      forbidden
    end
  end

  private

  def bus_travel_params
    params.require(:bus_travel).permit(:departure_on, :arrival_on, :travel_line_id)
  end

  def forbidden
    redirect_to root_path, alert: "Você não pode realizar esta ação."
  end
end
