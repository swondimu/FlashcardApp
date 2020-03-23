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
    var initialQuestion: String?
    var initialAnswer: String?
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(red: 0.88, green: 1.05, blue: 0.55, alpha: 1.00)
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            let alert = UIAlertController (title: "Missing text", message: "You must enter both a question and an answer.", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        } else {
                var isExisting = false
                  
                if (initialQuestion != nil) {
                      isExisting = true
                  }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting)
        
            dismiss(animated: true)
        }
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
           dismiss(animated: true)
       }

}
