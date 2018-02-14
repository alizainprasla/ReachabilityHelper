//
//  ReachabilityHelper.swift
//  ReachabilityTest
//
//  Created by Ali Zain Prasla on 2/14/18.
//  Copyright © 2018 Ali Zain Prasla. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager {
    
    static var shared = ReachabilityManager()
    
    private let reachability:Reachability?
    private var labelReachability:ReachabilityLabel?
    
    var controllers:[UIViewController]?
    
    private init() {
        
        reachability = Reachability()
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.setupLabel()
        }

        reachability?.whenReachable = { reachability in
            
            let connection = reachability.connection
            
            switch connection {
            case .cellular, .wifi:
                print("Internet Connected \(connection)")
                self.labelReachability?.didConnect()
                break
            case .none:
                print("No Connection Device")
                break
                
            }
        }
        
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.labelReachability?.didDisconnect()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        controllers = [UIViewController]()
        
    }

    func initialWithOwner(owner:AppDelegate){
        print(owner)
    }
    
    func setupLabel(){
        
        guard let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window else {
            return
        }

        let frame = CGRect(x: 0, y: 30, width: 420, height: 20)
        labelReachability = ReachabilityLabel(frame: frame)
        window.addSubview(labelReachability!)
        window.bringSubview(toFront: labelReachability!)

    }
    
    func stopNotifier(){
        reachability?.stopNotifier()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi,.cellular:
            print("Reachable via \(reachability.connection)")
        case .none:
            print("Network not reachable")
        }
    }
}
