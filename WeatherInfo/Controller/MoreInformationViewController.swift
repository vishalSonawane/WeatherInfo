//
//  MoreInformationViewController.swift
//  WeatherInfo
//
//  Created by vishalsonawane on 08/05/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit
import ElasticTransition
class MoreInformationViewController: ElasticModalViewController {
   
    /****
 var weatherDescription  = ""
 var temparature         = 0.0
 var pressure            = 0.0
 var humidity            = 0.0
 var country             = ""
 var city                = ""
 var minTemparature      = 0.0
 var maxTemparature      = 0.0
 **/
    
    @IBOutlet weak var labelWeatherDescriptionTitle: UILabel!
    
    @IBOutlet weak var labelWeatherDescriptionValue: UILabel!
    
    @IBOutlet weak var labelPressureTitle: UILabel!
    
    @IBOutlet weak var labelPressureValue: UILabel!
    
    @IBOutlet weak var labelHumidityTitle: UILabel!
    
    @IBOutlet weak var labelHumidityValue: UILabel!
    
    @IBOutlet weak var labelCountryTitle: UILabel!
    
    @IBOutlet weak var labelCountryValue: UILabel!
    
    @IBOutlet weak var labelMinTemparatureTitle: UILabel!
    
    @IBOutlet weak var labelMinTemparatureValue: UILabel!
    
    @IBOutlet weak var labelMaxTemparatureTitle: UILabel!
    
    @IBOutlet weak var labelMaxTemparatureValue: UILabel!
   
    
    
    var selectedWeatherInfo = WeatherInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        labelCountryTitle.text = "Country"
        labelCountryValue.text = selectedWeatherInfo.country.isEmpty ? "NO DATA" : selectedWeatherInfo.country
        labelHumidityTitle.text = "Humidity"
        labelHumidityValue.text = "\(selectedWeatherInfo.humidity)"
        labelPressureTitle.text = "Pressure"
        labelPressureValue.text = "\(selectedWeatherInfo.pressure)"
        labelMaxTemparatureTitle.text = "Max. Temparature"
        labelMaxTemparatureValue.text = "\(selectedWeatherInfo.maxTemparature)"
        labelMinTemparatureTitle.text = "Min. Temparature"
        labelMinTemparatureValue.text = "\(selectedWeatherInfo.minTemparature)"
        labelWeatherDescriptionTitle.text = "Description"
        labelWeatherDescriptionValue.text = selectedWeatherInfo.weatherDescription.isEmpty ? "NO DATA" : selectedWeatherInfo.weatherDescription
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

