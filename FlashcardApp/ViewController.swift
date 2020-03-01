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
        if (questionLabel.isHidden == false){
            questionLabel.isHidden = true
        }
        else if (questionLabel.isHidden == true){
            questionLabel.isHidden = false
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           let navigationController = segue.destination as! UINavigationController
           
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }

    
}

