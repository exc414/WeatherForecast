//
//File name     : WeatherPresenter.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/29/17
//

import Foundation

protocol WeatherPresenterProtocol
{
    //Post the weather or error information to main view.
    func postWeather(weather: WeatherCity);
    func postForecasts(forecasts: [WeatherForecast]);
    func postError(error: String);
}

class WeatherPresenter
{
    private var presenter: WeatherPresenterProtocol!;
    private var weatherService: WeatherService!;
    private var getWeatherURL: String!;
    private var getForecastURL: String!;
    
    init(presenter: WeatherPresenterProtocol)
    {
        self.presenter = presenter;
        //This should be an interface
        weatherService = WeatherService();
    }
    
    //Get weather infromation using the city name
    func getWeather(cityName: String)
    {
        getWeatherURL = BASE_WEATHER_URL + CITY_NAME + cityName;
        getForecastURL = BASE_FORECAST_WEATHER_URL + NUMBER_OF_DAYS_TO_RETRIEVE
            + CITY_NAME + cityName;
        
        post(getWeatherURL: getWeatherURL, getForecastURL: getForecastURL);
    }
    
    //When the apps first starts use the location services to get
    //where the user is and use that to get weather information.
    func onStartUp(lat: String, lon: String)
    {
        getWeatherURL = BASE_WEATHER_URL + LATITUDE + lat + LONGITUDE + lon;
        getForecastURL = BASE_FORECAST_WEATHER_URL + NUMBER_OF_DAYS_TO_RETRIEVE
            + LATITUDE + lat + LONGITUDE + lon;
        
        post(getWeatherURL: getWeatherURL, getForecastURL: getForecastURL);
    }
    
    private func post(getWeatherURL: String, getForecastURL: String)
    {
        weatherService.downloadWeatherDetails(getWeatherURL: getWeatherURL)
        {
            (weatherPayload: WeatherPayload) in
            
            //If its an error post it. If false then data was retrieve
            //successfully therefore post the weather object.
            if(weatherPayload.isError())
            {
                self.presenter.postError(error: weatherPayload.getMessage());
            }
            else { self.presenter.postWeather(weather: weatherPayload.getWeather()); }
        }
        
        weatherService.downloadWeatherForecast(getForecastURL: getForecastURL)
        {
            (weatherPayload: WeatherPayload) in
            
            if(weatherPayload.isError())
            {
                self.presenter.postError(error: weatherPayload.getMessage());
            }
            else { self.presenter.postForecasts(forecasts: weatherPayload.getForecasts()); }
        }
    }
}
