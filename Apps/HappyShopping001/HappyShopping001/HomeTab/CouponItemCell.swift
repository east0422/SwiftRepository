//
//  CouponItemCell.swift
//  HappyShopping001
//
//  Created by dfang on 2019-6-26.
//  Copyright © 2019年 east. All rights reserved.
//

import UIKit
import Toast_Swift

class CouponItemCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var itemUrl: String? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        logoImageView.frame = CGRect.init(x: 5, y: 10, width: 80, height: 80)
        logoImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func copyUrlClicked(_ sender: Any) {
        if (itemUrl != nil) {
            UIPasteboard.general.string = itemUrl
            self.makeToast("复制网址成功", duration: 3.0, position: ToastPosition.center)
        }
    }
}
