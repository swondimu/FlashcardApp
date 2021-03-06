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
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        assignbackground()
        card.layer.cornerRadius = 20.0
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        questionLabel.isHidden = false
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "Who is the first black female billionare?", answer: "Oprah Winfrey", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "background")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
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
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (deleteAction) in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
       }
    
    func deleteCurrentFlashcard() {
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateNextPrevButtons()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
            
        })
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
       flipFlashcards()
    }
    
    func flipFlashcards() {
        
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if (self.questionLabel.isHidden == false){
                self.questionLabel.isHidden = true
            }
            else if (self.questionLabel.isHidden == true){
                self.questionLabel.isHidden = false
            }
        })
    }

        func animateCardIn() {
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        }
        
        func animateCardOut() {
            UIView.animate(withDuration: 0.3, animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            }, completion: { finished in
                self.updateLabels()
                self.animateCardIn()
            })
        }
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer)
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
        
        if isExisting {
            print(currentIndex)
            flashcards[currentIndex] = flashcard
        } else {
           flashcards.append(flashcard)
           
           print("Added new flashcard")
           print("We now have \(flashcards.count) flashcards")
           
           currentIndex = flashcards.count - 1
           print("Our current index is \(currentIndex)")
       }
        
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
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
        }
        
       }

    
}

