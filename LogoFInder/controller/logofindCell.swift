//
//  logofindCell.swift
//  LogoFInder
//
//  Created by Janki on 04/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import UIKit

class logofindCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var viewcell: UIView!
 
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var logoName: UILabel!
    @IBOutlet weak var domainName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
