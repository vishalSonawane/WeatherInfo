//
//  WeatherInfoTableViewController.swift
//  WeatherInfo
//
//  Created by vishalsonawane on 08/05/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit
import SwiftLoader

//Define reusable cell identifier for cell
let CellIdentifier = "WeatherInfoTableViewCell"

let weatherInfoURL = URL(string: "http://api.openweathermap.org/data/2.5/group?id=4163971,2147714,2174003&units=metric&APPID=YOUR_KEY")!


class WeatherInfoTableViewController: UITableViewController {
 
    //Define weather info datasource
    var weatherInfoData = [WeatherInfo]()
    
    var refreshControll: UIRefreshControl!
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControll = UIRefreshControl()
        refreshControll.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControll.addTarget(self, action:#selector(loadWeatherInformation), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControll
        } else {
            // Fallback on earlier versions
            self.view.addSubview(refreshControll)
        }
        
        //Register custom tableview cell
        self.tableView.register(UINib(nibName: "WeatherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifier)
        
        //hide unnecessary seperator lines
        self.tableView.tableFooterView = UIView()
        
        SwiftLoader.show(title: "Loading Info...", animated: true)
        loadWeatherInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK: Customize loader
    func customizeLoader()  {
        //customize loader
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 100
        config.spinnerColor = .blue
        config.foregroundColor = .white
        config.foregroundAlpha = 0.5
        config.backgroundColor = .black
        SwiftLoader.setConfig(config)
    }
    
    //MARK: Show Alert View
    func showAlert(_ title: String, message:String) {
        let alertController = UIAlertController(title:title , message:message , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
           
            OperationQueue.main.addOperation({ 
                alertController.dismiss(animated: true, completion: nil)
                
                if #available(iOS 10.0, *) {
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.refreshControl?.attributedTitle = NSAttributedString()
                    self.tableView.refreshControl = nil
                    self.tableView.refreshControl = self.refreshControll
                    self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
                } else {
                    // Fallback on earlier versions
                    self.refreshControll?.endRefreshing()
                }
                SwiftLoader.hide()
                
            })
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Load weather information from server
    func loadWeatherInformation()  {
        //Fetch weather information
        
        WebHandler.fetchWeatherInfo(weatherInfoURL) { (result,status) in
            
            OperationQueue.main.addOperation({
                SwiftLoader.hide()
                self.refreshControll.endRefreshing()
                switch status {
                case .success:
                    //data retrieved successfully
                    self.weatherInfoData = result
                    self.tableView.reloadData()
                case .failure:
                    //something went wrong while parsing data
                    self.showAlert("🚫OOPS🚫", message: "Something went wrong.Please try again later")
                default:
                    //No Internet connection available
                    self.showAlert("🚫ERROR🚫", message: "Please check your internet conection.")
                }
            })
        }

    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherInfoData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! WeatherInfoTableViewCell

        // Configure the cell...
        let weatherInfo = weatherInfoData[indexPath.row]
        cell.setupCell(for: weatherInfo)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let moreDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MoreInformationViewController") as! MoreInformationViewController
        moreDetailsViewController.selectedWeatherInfo = weatherInfoData[indexPath.row]
        // customization:
        moreDetailsViewController.modalTransition.edge = .bottom
        moreDetailsViewController.modalTransition.radiusFactor = 0.5
        // ...
        moreDetailsViewController.modalTransition.transformType = .translateMid
       //moreDetailsViewController.modalTransition.showShadow = true
        moreDetailsViewController.modalTransition.damping = 0.5
        present(moreDetailsViewController, animated: true, completion: nil)
        
    
    }
}
