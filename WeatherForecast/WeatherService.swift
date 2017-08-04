//
//File name     : WeatherService.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/29/17
//

import Foundation
import Alamofire

class WeatherService
{
    private var weatherForecasts: [WeatherForecast]!;
    private var weatherForecast: WeatherForecast!;
    private var arrayOfInts: [Int] = [Int]();
    private var counter: Int = 0;
    
    /**
     * Still trying to comprehend @espcaing for closures. For now just know that
     * it stops the function downloadWeatherDetails from returning to its caller.
     * Or rather program execution wont go back to its caller, but wait until completed
     * is called inside of the Alamofire asyn task.
     *
     * If you dont use it, you cannot put completed() inside of the Alamofire request
     * which means the function will return before the async request comebacks which
     * causes the weather object that you pass on completed(weather) to be NULL.
     */
    public func downloadWeatherDetails(getWeatherURL: String,
                completed: @escaping(_ weatherPayload: WeatherPayload) -> Void)
    {

        Alamofire.request(getWeatherURL)
                 .responseJSON
        {
            response in
            
            let result = response.result;
            let weather: WeatherCity = WeatherCity();
            
            
            //Parse json
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let sys = dict["sys"] as? Dictionary<String, AnyObject>
                {
                    if let country = sys["country"] as? String
                    {
                        weather.setCountry(country: country);
                    }
                }
                
                //Looks through the  dict for the key named 'name'
                if let name = dict["name"] as? String
                {
                    //Capitalized makes the first letter in the city name a capital.
                    weather.setCityName(cityName: name.capitalized);
                }
                
                if let weatherArray = dict["weather"] as? [Dictionary<String, AnyObject>]
                {
                    if let main = weatherArray[0]["main"] as? String
                    {
                        weather.setWeatherType(weatherType: main.capitalized);
                    }
                }
                
                if let main  = dict["main"] as? Dictionary<String, AnyObject>
                {
                    if let temp = main["temp"] as? Double
                    {
                        weather.setCurrentTemp(currentTemp: self.convertToString(temp: temp));
                    }
                }
                
                //No errors above pass the weather object.
                completed(self.retrievalSuccess(weather: weather));
            }
            else
            {
                completed(self.retrievalFailure(message: "Current forecast error."));
            }
        }
    }
    
    public func downloadWeatherForecast(getForecastURL: String,
                completed: @escaping(_ weatherPayload: WeatherPayload) -> Void)
    {
        //Instantiate the array here. Not at the top of the class.
        //If this gets called multiple times it will keep adding into
        //the array instead of making a new one. Which is the desired effect.
        weatherForecasts = [WeatherForecast]();
        
        Alamofire.request(getForecastURL)
                 .responseJSON
        {
            response in
            
            let result = response.result;

            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                //Let list be an ARRAY of dictionary (Map)
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]
                {
                    //List of dictionaries (items)
                    for dictItem in list
                    {
                        //Create a new object each time to store items.
                        //If not the same object will repeat in the array.
                        self.weatherForecast = WeatherForecast();
                        
                        if let temp = dictItem["temp"] as? Dictionary<String, Double>
                        {
                            //No as? casting is need it. Swift knows its a double already.
                            if let maxTemp = temp["max"]
                            {
                                self.weatherForecast.setHighTemp(highTemp: self.convertToString(temp: maxTemp));
                            }
                            
                            if let minTemp = temp["min"]
                            {
                                self.weatherForecast.setLowTemp(lowTemp: self.convertToString(temp: minTemp));
                            }
                        }
                        
                        if let weatherArray = dictItem["weather"] as?
                            [Dictionary<String, AnyObject>]
                        {
                            if let main = weatherArray[0]["main"] as? String
                            {
                                self.weatherForecast.setWeatherType(weatherType: main.capitalized);
                            }
                        }
                        
                        //Have to cast it to a double from long (UInt32) because that is what the
                        //function takes.
                        if let date = dictItem["dt"] as? Double
                        {
                            let convertedDate = Date(timeIntervalSince1970: date);
                            self.weatherForecast.setDate(date: convertedDate.dayOfWeek()!);
                        }
                        
                        //Add new items.
                        self.weatherForecasts.append(self.weatherForecast);
                    }
                }
                
                //Dont need the first weather result as its the same as the same 
                //as the on populate by downloadWeatherDetails
                self.weatherForecasts.remove(at: 0);
                completed(self.retrievalSuccess(weatherForecasts: self.weatherForecasts));
            }
            else
            {
                completed(self.retrievalFailure(message: "Six day forecast error."));
            }
        }
    }
    
    private func convertToString(temp: Double) -> String
    {
        //Kevlin -> Fah formula.
        let fahrenheit = (temp * 1.8 - 459.67);
        //Rounds to one decimal place. 10 = 1, 100 = 2, 1000 = 3 and so on.
        return "\(Double(round(10 * fahrenheit / 10)))";
    }
    
    private func retrievalFailure(message: String) -> WeatherPayload
    {
        let weatherPayload: WeatherPayload = WeatherPayload();
        weatherPayload.setError(error: true);
        weatherPayload.setMessage(message: message);
        return weatherPayload;
    }
    
    private func retrievalSuccess(weather: WeatherCity) -> WeatherPayload
    {
        let weatherPayload: WeatherPayload = WeatherPayload();
        weatherPayload.setWeather(weather: weather);
        weatherPayload.setError(error: false);
        return weatherPayload;
    }
    
    private func retrievalSuccess(weatherForecasts: [WeatherForecast]) -> WeatherPayload
    {
        let weatherPayload: WeatherPayload = WeatherPayload();
        weatherPayload.setForecasts(forecasts: weatherForecasts);
        weatherPayload.setError(error: false);
        return weatherPayload;
    }
}

extension Date
{
    func dayOfWeek() -> String?
    {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "EEEE";
        return dateFormatter.string(from: self).capitalized;
    }
}
