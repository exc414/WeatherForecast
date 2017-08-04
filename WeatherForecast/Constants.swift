//
//File name     : Constants.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/29/17
//

import Foundation

//Base
let BASE_URL = "http://api.openweathermap.org/data/2.5/";
let CURRENT_WEATHER = "weather?"
let APP_ID = "appid=";
let API_KEY = "200de3f74719b34cf65f1b652b9c13ed";
let BASE_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(APP_ID)\(API_KEY)";

//Base Query Attributes
let LATITUDE = "&lat=";
let LONGITUDE = "&lon=";
let CITY_NAME = "&q=";

//Base Forecast
let FORECAST_WEATHER = "forecast/daily?"
let NUMBER_OF_DAYS_TO_RETRIEVE = "&cnt=7"
let BASE_FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_WEATHER)\(APP_ID)\(API_KEY)\(NUMBER_OF_DAYS_TO_RETRIEVE)";

//Set Fahrenheit and Celsius endings.
let fahrenheit = " °F";
let celsius = " °C";
