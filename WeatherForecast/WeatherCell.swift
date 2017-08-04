//
//File name     : WeatherCell.swift
//Project name  : WeatherForecast
//Created by    : Carlos Perez
//Created on    : 7/29/17
//

import UIKit

class WeatherCell: UITableViewCell
{
    @IBOutlet weak var weatherIcon: UIImageView!;
    @IBOutlet weak var lblDate: UILabel!;
    @IBOutlet weak var weatherType: UILabel!;
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureCell(forecast: WeatherForecast)
    {
        lowTemp.text = forecast.getLowTemp() + fahrenheit;
        highTemp.text = forecast.getHighTemp() + fahrenheit;
        lblDate.text = forecast.getDate();
        weatherType.text = forecast.getWeatherType();
        weatherIcon.image = UIImage(named: forecast.weatherType);
    }
}
