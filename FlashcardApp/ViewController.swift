//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Samara Wondimu on 2/21/20.
//  Copyright © 2020 Samara Wondimu. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionLabel.isHidden = false
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
        updateFlashcard(question:"Who is the first black female billionare?", answer: "Oprah Winfrey")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
        flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateLabels () {
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    }

    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
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
        let flashcard = Flashcard(question: question, answer: answer)
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           let navigationController = segue.destination as! UINavigationController
           
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }

    
}

