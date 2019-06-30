//
//  MineItemCell.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-27.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit

class MineItemCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
