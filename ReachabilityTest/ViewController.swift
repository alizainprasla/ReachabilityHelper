//
//  ViewController.swift
//  ReachabilityTest
//
//  Created by Ali Zain Prasla on 2/14/18.
//  Copyright © 2018 Ali Zain Prasla. All rights reserved.
//

import UIKit



extension UIViewController {
    func internetDidConnect(){}
    func internetDidDisconnect(){}
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityManager.shared.onConnection(controller: self)
    }
    
    
    
    func internetConnection() {
        var i = 0
        self.navigationController?.viewControllers.forEach({ (controller) in
            if controller == self{
                print("controller in index == \(i)")
            }
            i += 1
        })
    }
    
    @IBAction func actionPush(){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "Controller")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

