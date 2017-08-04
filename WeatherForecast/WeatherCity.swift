//
//File name     : WeatherCity.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/29/17
//

import Foundation

//Model object
class WeatherCity
{
    private var cityName: String!;
    private var date: String!;
    private var weatherType: String!;
    private var currentTemp: String!;
    private var country: String!;
    
    public func setCityName(cityName: String)
    {
        self.cityName = cityName;
    }
    
    public func getCityName() -> String
    {
        return cityName;
    }
    
    public func setCountry(country: String)
    {
        self.country = country;
    }
    
    public func getCountry() -> String
    {
        return country;
    }
    
    public func setDate(date: String)
    {
        self.date = date;
    }
    
    public func getDate() -> String
    {
        if(date == nil) { date = ""; }
        
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateStyle = .long;
        dateFormatter.timeStyle = .none;
        let currentDate: String = dateFormatter.string(from: Date());
        self.date = "\(currentDate)";
        
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
    
    public func setCurrentTemp(currentTemp: String)
    {
        self.currentTemp = currentTemp;
    }
    
    public func getCurrentTemp() -> String
    {
        return currentTemp;
    }
}
