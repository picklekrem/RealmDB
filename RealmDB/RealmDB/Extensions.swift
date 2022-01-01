//
//  Extensions.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 30.12.2021.
//

import UIKit

extension UIViewController  {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 0 , y: self.view.frame.size.height-100, width: view.frame.size.width, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIView {
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func cardView() {
        self.backgroundColor = .systemBackground
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
    
    func roundedCorners() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
}

extension UITextField {
    
    func addColoredBottomBorder(color:UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension UISearchBar {
    
    func addColoredBottomBorder(color:UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        self.searchTextField.borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension UILabel {
    
    func addColoredBottomBorder(color:UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        self.layer.borderWidth = 0
        layer.addSublayer(bottomLine)
    }
}
