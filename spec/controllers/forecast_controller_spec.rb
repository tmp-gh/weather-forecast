require 'spec_helper'

describe ForecastController, :type => :controller  do
  describe 'GET #fetch' do
    context "when forecast is requested for only zipcode" do
      before do
        get :fetch, params: {"address_1"=>"", "address_2"=>"", "city"=>"", "state"=>"", "country"=>"", "zipcode"=>"10001", "commit"=>"Get Forecast"}
      end

      it 'success response' do
        expect(response).to be_successful
      end

      it 'return weather info for that particular zipcode' do
        expect(assigns(:weather_data).present?).to eq true
      end

      it 'weather info has city name' do
        expect(assigns(:weather_data)["name"]).to eq "New York"
      end
    end

    context "when forecast is requested for city, state and country" do
      before do
        get :fetch, params: {"address_1"=>"", "address_2"=>"", "city"=>"New York", "state"=>"New York", "country"=>"USA", "zipcode"=> nil, "commit"=>"Get Forecast"}
      end

      it 'success response' do
        expect(response).to be_successful
      end

      it 'return weather info for that particular combination' do
        expect(assigns(:weather_data).present?).to eq true
      end

      it 'weather info has city name' do
        expect(assigns(:weather_data)["name"]).to eq "New York"
      end
    end

    context "when forecast is requested for only state" do
      before do
        get :fetch, params: {"address_1"=>"", "address_2"=>"", "city"=>"", "state"=>"New York", "country"=>"", "zipcode"=> "", "commit"=>"Get Forecast"}
      end

      it 'success response' do
        expect(response).to be_successful
      end

      it 'no weather info is fetched for this particular combination' do
        expect(assigns(:weather_data).present?).to eq false
      end
    end
  end
end
