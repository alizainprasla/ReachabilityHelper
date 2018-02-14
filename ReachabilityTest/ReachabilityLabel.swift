//
//  ReachabilityLabel.swift
//  ReachabilityTest
//
//  Created by Ali Zain Prasla on 2/14/18.
//  Copyright © 2018 Ali Zain Prasla. All rights reserved.
//

import UIKit

class ReachabilityLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 12)
        self.textColor = UIColor.white
        self.alpha = 0
    }
    
    func didConnect(){
        
        self.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: { 
            self.backgroundColor = UIColor.hexaColor(hex: "#61BD6D")
            self.alpha = 0
            self.text = "Internet has been connected"
        }, completion: nil)
        

    }
    
    func didDisconnect(){
        
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor.hexaColor(hex: "#B8312F")
            self.alpha = 1
            self.text = "Internet is not connected"
        }, completion: nil)
    }
}


extension UIColor {
    
    static func hexaColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
