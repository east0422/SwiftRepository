//
//  ViewController.swift
//  OpenCVDemo
//
//  Created by dfang on 2017-10-26.
//  Copyright © 2017年 com.east. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var detectSwitch: UISwitch!
    @IBOutlet weak var cameraBtn: UIButton!
    var curImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgView.image = UIImage.init(named: "temp.jpg")
        curImage = imgView.image
        detectSwitchClicked(detectSwitch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detectSwitchClicked(_ sender: UISwitch) {
        if (detectSwitch.isOn) {
            imgView.image = OpenCVWrapper.detectAndDraw(with: curImage)
            // just test base64
//            let base64 = UIImagePNGRepresentation(curImage)?.base64EncodedString()
//            imgView.image = OpenCVWrapper.detectAndDraw(withBase64: base64)
        } else {
            imgView.image = curImage
        }
    }
    
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            let picker = UIImagePickerController.init()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraDevice = UIImagePickerControllerCameraDevice.front
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            print("Error, device not support camera!")
        }
    }

    @IBAction func cropClicked(_ sender: UIButton) {
        let images = OpenCVWrapper.detectEye(curImage);
        if (nil == images || 0 == images?.count) {
            showMessage(message: "识别该图片中眼睛失败!")
            return
        }
        
        for img in images! {
            UIImageWriteToSavedPhotosAlbum(img as! UIImage, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         // UIImagePickerControllerEditedImage, UIImagePickerControllerMediaMetadata, UIImagePickerControllerMediaType, UIImagePickerControllerOriginalImage
        curImage = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true) {
            self.detectSwitchClicked(self.detectSwitch)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if (error == nil) {
            showMessage(message: "保存眼睛图片成功！")
        } else {
            showMessage(message: "识别该图片中眼睛失败!")
        }
    }
    
    func showMessage(message: NSString) {
        let window = UIApplication.shared.windows.first
        let showView = UIView.init(frame: CGRect.init(x: 1, y: 1, width: 1, height: 1))
        showView.backgroundColor = UIColor.black
        showView.alpha = 1.0
        showView.layer.cornerRadius = 5.0
        showView.layer.masksToBounds = true
        window?.addSubview(showView)
        window?.bringSubview(toFront: showView)
        
        let labelSize = message.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)])
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 5, width: labelSize.width, height: labelSize.height + 30))
        label.text = message as String
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.init(rawValue: 1)!
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        showView.addSubview(label)
        showView.frame = CGRect.init(x: (UIScreen.main.bounds.size.width - labelSize.width - 20) / 2 , y: (UIScreen.main.bounds.size.height - labelSize.height - 20) / 2, width: labelSize.width + 20, height: labelSize.height + 50)
        UIView.animate(withDuration: 3, animations: {
            showView.alpha = 0
        }) { (Bool) in
            showView.removeFromSuperview()
        }
    }
}
