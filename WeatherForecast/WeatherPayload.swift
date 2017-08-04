//
//File name     : WeatherPayload.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/30/17.
//

import Foundation

class WeatherPayload
{
    
    private var weather: WeatherCity!;
    private var error: Bool!;
    private var message: String!;
    private var forecasts: [WeatherForecast]!;
    
    public func setWeather(weather: WeatherCity)
    {
        self.weather = weather;
    }
    
    public func getWeather() -> WeatherCity
    {
        return weather;
    }
    
    public func setError(error: Bool)
    {
        self.error = error;
    }
    
    public func isError() -> Bool
    {
        return error;
    }
    
    public func setMessage(message: String)
    {
        self.message = message;
    }
    
    public func getMessage() -> String
    {
        return message;
    }
    
    public func setForecasts(forecasts: [WeatherForecast])
    {
        self.forecasts = forecasts;
    }
    
    public func getForecasts() -> [WeatherForecast]
    {
        return forecasts;
    }
    
}
