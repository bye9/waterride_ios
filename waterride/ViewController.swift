//
//  ViewController.swift
//  waterride
//
//  Created by JeongHwan Seok on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var currentPrice: UITextField!
    @IBOutlet weak var currentNum: UITextField!
    @IBOutlet weak var newPrice: UITextField!
    @IBOutlet weak var newNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.currentPrice.becomeFirstResponder()
        
    }


}

