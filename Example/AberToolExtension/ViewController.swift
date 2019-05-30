//
//  ViewController.swift
//  AberToolExtension
//
//  Created by aberfield on 08/29/2018.
//  Copyright (c) 2018 aberfield. All rights reserved.
//

import UIKit
import AberToolExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var a = [1,2,1,2,3,4,5]
        a.removeDuplicates()
        print(a)
        print(a)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

