//
//  WeatherInfoTableViewCell.swift
//  WeatherInfo
//
//  Created by vishalsonawane on 08/05/17.
//  Copyright © 2017 vishalsonawane. All rights reserved.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTemparature: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setupCell(for weatherInfo:WeatherInfo)  {
        //
        self.labelCityName.text = weatherInfo.city
        self.labelTemparature.text = "\(weatherInfo.temparature)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
