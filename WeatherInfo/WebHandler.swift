//
//  WebHandler.swift
//  WeatherInfo
//
//  Created by vishalsonawane on 08/05/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit

enum STATUS {
    case success
    case failure
    case noInternet
}


class WebHandler: NSObject {
typealias CompletionHandler = (_ result:([WeatherInfo],STATUS)) -> Void
//MARK:===========================  Download Data from Service ===========================
   static func fetchWeatherInfo(_ url: URL,completionHandler: @escaping CompletionHandler){
    var weatherInfoData = [WeatherInfo]()
    var status = STATUS.success
    //Chek if internet is available or not
    if NetworkManager.isConnectedToNetwork(){
            
            //let url : URL = URL(string: urlString)!
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                if let data = data {
                    
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                        print(json ?? "No JSON data")
                        let weatherList = json?["list"] as! [[String:Any]]
                       
                        for listItem in weatherList
                        {
                            
                            //Parse weather data
                            let weatherInfo = listItem["weather"] as! [[String:Any]]
                            let weatherInfoDetails = weatherInfo.first
                            let weatherDescription = weatherInfoDetails?["description"] as? String ?? "No  description"
                            print(weatherDescription)
                            //Parse main dictionary
                            let mainInfo = listItem["main"] as! [String:Any]
                            let temparature = mainInfo["temp"] as! Double
                            let humidity = mainInfo["humidity"] as! Double
                            let pressure = mainInfo["pressure"] as! Double
                            let min_temparature = mainInfo["temp_min"] as! Double
                            let max_temparature = mainInfo["temp_max"] as! Double
                            print(mainInfo)
                            //Parse name
                            let city = listItem["name"] as! String
                            
                            //Parse country name
                            let sysInfo = listItem["sys"] as! [String:Any]
                            let country = sysInfo["country"] as! String
                            
                            //prepare weather info array
                            
                            let weatherInfoObject = WeatherInfo()
                            weatherInfoObject.temparature = temparature
                            weatherInfoObject.minTemparature = min_temparature
                            weatherInfoObject.maxTemparature = max_temparature
                            weatherInfoObject.country = country
                            weatherInfoObject.humidity = humidity
                            weatherInfoObject.pressure = pressure
                            weatherInfoObject.city = city
                            weatherInfoObject.weatherDescription = weatherDescription
                            
                            weatherInfoData.append(weatherInfoObject)
                        }
                    } else {
                       status = STATUS.failure
                        print("Data not fetched from server")
                        completionHandler((weatherInfoData,status))
                    }
                }
                //notify back to caller
                let returnResponseTuple = (weatherInfoData ,status)
                completionHandler(returnResponseTuple)
            })
            
            task.resume()
        }else{
            status = STATUS.noInternet
            print("Device internet is not Working")
            completionHandler((weatherInfoData,status))
        }
    
    }
}
