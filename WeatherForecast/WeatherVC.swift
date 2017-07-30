//  WeatherVC.swift
//  WeatherForecast
//
//  Created by Carlos Perez on 7/28/17.
//  Copyright © 2017 Carlos Perez. All rights reserved.

import UIKit

class WeatherVC: UIViewController
{
    @IBOutlet weak var lblDate: UILabel!;
    @IBOutlet weak var lblCurrentTemp: UILabel!;
    @IBOutlet weak var lblLocation: UILabel!;
    @IBOutlet weak var imgCurrentWeather: UIImageView!;
    @IBOutlet weak var lblCurrentWeather: UILabel!;
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: WeatherPresenter!;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //Launched from the create method and not resuming.
        //Meaning there is nothing populate.
        if(didLaunchFromScratch.boolValue)
        {
            presenter = WeatherPresenter(presenter: self);
            presenter.onStartUp(lat: "27.9475", lon: "-82.4585");
        }
    }
}

extension WeatherVC: UITableViewDelegate { }

extension WeatherVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    //How many rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6;
    }
    
    //Reuse cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell;
    }
}

extension WeatherVC: WeatherPresenterProtocol
{
    func postWeather(weather: Weather)
    {
        print("City Name : " + weather.getCityName());
        print("Weather Type : " + weather.getWeatherType());
        print("Temp : \(weather.getCurrentTemp())");
    }
    
    func postError(error: String)
    {
        //TODO : add toast to let the user know the error message.
    }
}

