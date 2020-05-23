//
//  NumberedViewController.swift
//  Screens (iOSPT6)
//
//  Created by Bohdan Tkachenko on 4/21/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class NumberedViewController: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up programettic view
        
        //set initial view
        view.addSubview(label)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.center = view.center
        
    }
    //set up?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let number = navigationController?.viewControllers.count {
            label.text = String(number)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // when presented modally: self.dismiss(animated: true) - But these controllers are part of nav controller so we do this:
        
        //Goes back one step in the stack
        //self.navigationController?.popViewController(animated: true)
        
        //Go back to the root view controller
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
