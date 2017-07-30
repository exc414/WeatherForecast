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
                completed: @escaping (_ weatherPayload: WeatherPayload) -> Void)
    {
        Alamofire.request(getWeatherURL)
                 .validate()
                 .responseJSON
        {
            response in
            
            let result = response.result;
            let weather: Weather = Weather();
            let errorIn: String = "Error in retrieving";
            
            //Parse json
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                //Looks through the  dict for the key named 'name'
                if let name = dict["name"] as? String
                {
                    //Capitalized makes the first letter in the city name a capital.
                    weather.setCityName(cityName: name.capitalized);
                    print("City Name : " + weather.getCityName());
                }
                else
                {
                    completed(self.retrievalFailure(message: errorIn + " city name!"));
                }
                
                if let weatherArray = dict["weather"] as? [Dictionary<String, AnyObject>]
                {
                    if let main = weatherArray[0]["main"] as? String
                    {
                        weather.setWeatherType(weatherType: main.capitalized);
                    }
                }
                else
                {
                    completed(self.retrievalFailure(message: errorIn + " weather type!"));
                }
                
                if let main  = dict["main"] as? Dictionary<String, AnyObject>
                {
                    if let temp = main["temp"] as? Double
                    {
                        let fahrenheit = (temp * 1.8 - 459.67);
                        //Rounds to one decimal place. 10 = 1, 100 = 2, 1000 = 3 and so on.
                        weather.setCurrentTemp(currentTemp: Double(round(10 * fahrenheit / 10)));
                    }
                }
                else
                {
                    completed(self.retrievalFailure(message: errorIn + " temperature!"));
                }
                
                //No errors above pass the weather object.
                completed(self.retrievalSuccess(weather: weather));
            }
            else
            {
                completed(self.retrievalFailure(message: "General error, data malformed!"));
            }
        }
    }
    
    private func retrievalFailure(message: String) -> WeatherPayload
    {
        let weatherPayload: WeatherPayload = WeatherPayload();
        weatherPayload.setError(error: true);
        weatherPayload.setMessage(message: message);
        return weatherPayload;
    }
    
    private func retrievalSuccess(weather: Weather) -> WeatherPayload
    {
        let weatherPayload: WeatherPayload = WeatherPayload();
        weatherPayload.setError(error: false);
        weatherPayload.setWeather(weather: weather)
        return weatherPayload;
    }
}
