//
//  ViewController.swift
//  ming BASIC
//
//  Created by Leping Qiu on 2020/8/3.
//  Copyright © 2020 bluemagic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var introductionText: UILabel!
    @IBOutlet weak var learnPageButton: UIButton!
    @IBOutlet weak var practicePageButton: UIButton!
    @IBOutlet weak var evaluatePageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页"
        learnPageButton.layer.cornerRadius = 15.0
        practicePageButton.layer.cornerRadius = 15.0
        evaluatePageButton.layer.cornerRadius = 15.0
        
        
        // Do any additional setup after loading the view.
    }


}

