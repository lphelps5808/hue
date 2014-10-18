//
//  LightControlTableViewCell.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/14/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class LightControlTableViewCell: UITableViewCell {

    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var controlSlider: UISlider!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .None
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
