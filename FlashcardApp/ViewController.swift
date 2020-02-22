//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Samara Wondimu on 2/21/20.
//  Copyright © 2020 Samara Wondimu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionLabel.isHidden = false
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden = true
    }
    
}

