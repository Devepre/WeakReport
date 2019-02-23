//
//  ViewController.swift
//  WeakReport
//
//  Created by Limitation on 2/23/19.
//  Copyright © 2019 Serhii K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    private var center = SomeCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.registerObserver(self)
    }

    // MARK: - Initiate changing of the datasource.
    @IBAction func trueAction(_ sender: UIButton) {
        center.changeValueToTrue()
    }
    
    
    @IBAction func falseAction(_ sender: UIButton) {
        center.changeValueToFalse()
    }
    
}

// MARK: - SomeObserving is where result of observing happens.
extension ViewController: SomeObserving {
    func didBecomeEnable(with value: String) {
        resultLabel.text = value
    }
    
    func didBecomeDisable(with value: String) {
        resultLabel.text = value
    }
    
}

