//
//  RedViewController.swift
//  Screens (iOSPT6)
//
//  Created by Bohdan Tkachenko on 4/21/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class RedViewController: NumberedViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  //Unwind Segue to particulare viewController could be any
    //goes back to VC that you want to unwind to (root view controller)
    //leave the body empty
   @IBAction func unwindToRed(_ sender: UIStoryboardSegue) {
        //lcan do additional preperation
    }

}
