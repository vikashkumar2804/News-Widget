//
//  ViewController.swift
//  News
//
//  Created by Vikash on 05/07/17.
//  Copyright © 2017 Vikash. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var lable: UILabel!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lable.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 10)
      //  self.textField.delegate=self
      //let  emailPH =  textField.addPlaceHolder(mainView: self.view, placeHolderText: "Email")
    // let  passwordPH = tfPassword.addPlaceHolder(mainView: self.view, placeHolderText: "Password")
//        print(emailPH.text ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        let picker = UIDatePicker()
//        picker.setValue(UIColor.blue, forKeyPath: "textColor")
//        picker.datePickerMode = .date
//        textField.inputView = picker
//        textField.inputView?.backgroundColor = UIColor.black // my desired color
//        
//       // picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
//        
//    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
//extension UITextField{
//    
//    func addPlaceHolder(mainView: UIView, placeHolderText: String) -> UILabel {
//        let label = UILabel()
//        label.text = placeHolderText
//        label.font = label.font.withSize(14)
//        label.textColor = UIColor.black
//        label.translatesAutoresizingMaskIntoConstraints=false
//        mainView.addSubview(label)
//        var leadingAnchorConst: NSLayoutConstraint?
//        var centerConst: NSLayoutConstraint?
//        
//        if #available(iOS 9.0, *) {
//            leadingAnchorConst = label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:10)
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 9.0, *) {
//            centerConst =  label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        } else {
//            // Fallback on earlier versions
//        }
//        NSLayoutConstraint.activate([leadingAnchorConst!, centerConst!])
//        return label
//    }
//    
//}
