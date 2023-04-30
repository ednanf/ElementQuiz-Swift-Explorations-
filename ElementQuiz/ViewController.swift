//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Ednan R. Frizzera Filho on 30/04/23.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}

class ViewController: UIViewController {

// MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var modeSelector: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    
// MARK: - Properties
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"] // This array will be used both as a reference for the image files in imageView and text answer in answerLabel.
    var currentElementIndex = 0 // Variable to keep track of the currently selected element.
    var mode: Mode = .flashCard // This variable holds the information if the app is either in flashCard or quiz modes.
    var state: State = .question // This variable holds the information if the app is either showing the question or the answer in answerLabel.
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    
// MARK: - IBActions
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer // When the button showAnswer is pressed, set the State to .answer.
        
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1 // Since we access items in an array by index, we can calculate the value of the next element by adding 1 to the current index.
        if currentElementIndex == elementList.count {
            currentElementIndex = 0
        } // This if statement prevents the app crashing for going out of range. If the index's number is equal to currentElementIndex, it will simply set it back to 0, causing a loop.
        
        state = .question // When the next button is pressed, set the State to .question (returning from .answer which the user most likely pressed).
        
        updateUI() // After adding 1 to the currentElementIndex, the interface must be updated.
    }
    
    
// MARK: - Functions
    
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex] // This constant accesses the element name from the list using the currentElementIndex property as the index.
        let image = UIImage(named: elementName) // This line creates a new UIImage instance by looking for an image in the Asset Catalog with a matching name.
        imageView.image = image // This line sets the image of the image view to the newly created image instance.
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    } // This method is supposed to answer the question "For the current state of the app, how the UI should look?"
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI() {
        
    }
    
    // Updates the app's UI based on its mode and state.
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    } // The only method that should ever call updateFlashCardUI (and updateQuizUI) should be updateUI. All other methods will rely on updateUI when they make changes to the interface.
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
