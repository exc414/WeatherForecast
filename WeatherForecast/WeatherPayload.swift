//
//File name     : WeatherPayload.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/30/17.
//

import Foundation

class WeatherPayload
{
    
    private var weather: Weather!;
    private var error: Bool!;
    private var message: String!;
    
    public func setWeather(weather: Weather)
    {
        self.weather = weather;
    }
    
    public func getWeather() -> Weather
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
    
}
