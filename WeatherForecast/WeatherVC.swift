//
//File name     : WeatherVC.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez
//Created on    : 7/29/17
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController
{
    @IBOutlet weak var lblDate: UILabel!;
    @IBOutlet weak var lblCurrentTemp: UILabel!;
    @IBOutlet weak var lblLocation: UILabel!;
    @IBOutlet weak var imgCurrentWeather: UIImageView!;
    @IBOutlet weak var lblCurrentWeather: UILabel!;
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtInputCity: UITextField!
    
    fileprivate let locationManager = CLLocationManager();
    fileprivate var currentLocation: CLLocation!;
    
    fileprivate var forecasts: [WeatherForecast]!;
    fileprivate var presenter: WeatherPresenter!;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startMonitoringSignificantLocationChanges();
        
        tableView.delegate = self;
        tableView.dataSource = self;
        txtInputCity.delegate = self;
        
        //Instantiate the array
        forecasts = [WeatherForecast]();
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        presenter = WeatherPresenter(presenter: self);
        locationAuthStatus();
    }
    
    @IBAction func txtInputCity(_ sender: UITextField) { }
    
    @IBAction func btnNewCity(_ sender: UIButton)
    {
        txtInputCity.isHidden = false;
        txtInputCity.becomeFirstResponder();
    }
    
    fileprivate func sendCityName(cityName: String)
    {
        if(!cityName.isEmpty)
        {
            presenter.getWeather(cityName: cityName);
        }
    }
    
    fileprivate func locationAuthStatus()
    {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse)
        {
            currentLocation = locationManager.location;
            let latStr: String = String(format:"%f", currentLocation.coordinate.latitude);
            let lonStr: String = String(format:"%f", currentLocation.coordinate.longitude);
            presenter.onStartUp(lat: latStr, lon: lonStr);
        }
        else
        {
            //Opens pop-up asking the user to allow
            //the retrieval of their location
            locationManager.requestWhenInUseAuthorization();
            //Call again once authorized.
            locationAuthStatus();
        }
    }
}

extension WeatherVC: UITextFieldDelegate
{
    //Hide keyboard and get text once the user click return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        sendCityName(cityName: textField.text!);
        textField.resignFirstResponder()
        textField.isHidden = true;
        textField.text = "";
        return true
    }
    
    //Force the user to only type Upper/lower caser letter and commas.
    //Since the input wer are looking for is Tampa,US.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let characterSet = CharacterSet.init(
            charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,");
        
        if string.rangeOfCharacter(from: characterSet.inverted) != nil
        {
            return false;
        }
        
        return true;
    }
}

extension WeatherVC: CLLocationManagerDelegate { }

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
        return forecasts.count;
    }
    
    //Reuse cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            //Wire the forecast to the cell memebers
            let forecast = forecasts[indexPath.row];
            cell.configureCell(forecast: forecast);
            return cell;
        }
        else
        {
            return WeatherCell();
        }
    }
}

extension WeatherVC: WeatherPresenterProtocol
{
    func postWeather(weather: WeatherCity)
    {
        lblLocation.text = weather.getCityName() + ", " + weather.getCountry();
        lblDate.text = weather.getDate();
        lblCurrentTemp.text = weather.getCurrentTemp() + fahrenheit;
        lblCurrentWeather.text = weather.getWeatherType();
        imgCurrentWeather.image = UIImage(named: weather.getWeatherType());
    }
    
    func postForecasts(forecasts: [WeatherForecast])
    {
        self.forecasts = forecasts;
        //Make sure to reaload the table or the data wont show.
        self.tableView.reloadData();
    }
    
    func postError(error: String)
    {
        //TODO : add toast to let the user know the error message.
    }
}
