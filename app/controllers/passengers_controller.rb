class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
    #@passengers = Passenger.paginate :all, :page => params[:page], :per_page => 10
    @passengers = Passenger.paginate(:page => params[:page], :per_page => 8)
    #@posts = Post.all.order(created_at: :desc).paginate(page:  params[:page], per_page: 2)
    # @passengers = Passenger.where(passenger_trip: passenger_trips_ids)
  end

  def show
    @passenger = Passenger.find(params[:id])
    @passenger_trips = PassengerTrip.where(passenger: @passenger)
  end

  def new
    # @travel_line = TravelLine.find(travel_line_id: bus_travel.travel_line.travel_line_id)
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passenger_path, notice: "Passageiro cadastrado com sucesso!"
    else
      render :new
    end
  end

  # def destroy
  #   @passenger = passenger.find(params[:id])
  #   @passenger.destroy
  #   redirect_to companies_path
  # end

  private

  def passenger_params
    params.require(:passenger).permit(:full_name, :date_of_birth, :gender, :cpf, :identification_number, :identification_state)
  end
end
