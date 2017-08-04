//
//File name     : WeatherForecast.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/30/17.
//

import Alamofire

class WeatherForecast
{
    var date: String!;
    var weatherType: String!;
    var highTemp: String!;
    var lowTemp: String!;
    
    public func setDate(date: String)
    {
        self.date = date;
    }
    
    public func getDate() -> String
    {
        return date;
    }
    
    public func setWeatherType(weatherType: String)
    {
        self.weatherType = weatherType;
    }
    
    public func getWeatherType() -> String
    {
        return weatherType;
    }
    
    public func setHighTemp(highTemp: String)
    {
        self.highTemp = highTemp;
    }
    
    public func getHighTemp() -> String
    {
        return highTemp;
    }
    
    public func setLowTemp(lowTemp: String)
    {
        self.lowTemp = lowTemp;
    }
    
    public func getLowTemp() -> String
    {
        return lowTemp;
    }
}
