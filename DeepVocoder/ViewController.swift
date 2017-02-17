//
//  ViewController.swift
//  DeepVocoder
//
//  Created by Karthik Kannan on 17/02/17.
//  Copyright © 2017 Karthik Kannan. All rights reserved.
//

import UIKit
import Hero

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print("In VC")
        
        let layer = CAGradientLayer()
        layer.frame = view.frame
        layer.colors = [UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0).cgColor, UIColor(red:0.17, green:0.17, blue:0.17, alpha:1.0).cgColor]
        view.layer.addSublayer(layer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

