//
//  MessageViewController.swift
//  Storyboard
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    let messages = [
        "Ouch, that hurts",
        "Please don't do that again",
        "Why did you press that?",
        ]
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func changeMessage() {
        message.text = messages[Int(arc4random_uniform(UInt32(messages.count)))]
    }
    
    @IBAction func about(sender: AnyObject) {
        performSegue(withIdentifier: "about", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "about" {
            let dest = segue.destination as UIViewController
            dest.view.backgroundColor = message.backgroundColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        message.backgroundColor = UIColor(
            red:red,
            green:green,
            blue:blue,
            alpha:0.5
        )
    }
}
