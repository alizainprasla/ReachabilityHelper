//
//  ViewController.swift
//  ReachabilityTest
//
//  Created by Ali Zain Prasla on 2/14/18.
//  Copyright © 2018 Ali Zain Prasla. All rights reserved.
//

import UIKit

class BaseController : UIViewController {
    
    func internetConnection(){
        print("internetConnection")
    }
    
}

class ViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityManager.shared.onConnection(controller: self)
    }
    
    override func internetConnection() {
        super.internetConnection()
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

