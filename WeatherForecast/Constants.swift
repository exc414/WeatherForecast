//
//File name     : Constants.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez 
//Created on    : 7/29/17
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?";
let LATITUDE = "&lat=";
let LONGITUDE = "&lon=";
let CITY_NAME = "q=";
let APP_ID = "appid=";
let API_KEY = "200de3f74719b34cf65f1b652b9c13ed";
var didLaunchFromScratch: DarwinBoolean = false;

let BASE_WEATHER_URL = "\(BASE_URL)\(APP_ID)\(API_KEY)";
