//
//  LightOnOffTableViewCell.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/14/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class LightOnOffTableViewCell: UITableViewCell {

    var onOffSwitch = UISwitch()
    var label = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.contentView.addSubview(onOffSwitch)
        label.text = "On / Off"
        self.contentView.addSubview(label)
        
        self.selectionStyle = .None
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = self.contentView.bounds.size.height
        let width = self.contentView.bounds.size.width
        
        let switchYPos = (height - onOffSwitch.frame.size.height) * 0.5
        onOffSwitch.frame = CGRect(x: width - onOffSwitch.frame.size.width - 15, y: switchYPos, width: onOffSwitch.frame.size.width, height: onOffSwitch.frame.size.height)
        
        label.sizeToFit()
        let labelYPos = (height - label.frame.size.height) * 0.5
        label.frame = CGRect(x: 15, y: labelYPos, width: label.frame.size.width, height: label.frame.size.height)
        
    }

}
