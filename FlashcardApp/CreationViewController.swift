//
//  CreationViewController.swift
//  FlashcardApp
//
//  Created by Samara Wondimu on 2/29/20.
//  Copyright © 2020 Samara Wondimu. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
           dismiss(animated: true)
       }

}
