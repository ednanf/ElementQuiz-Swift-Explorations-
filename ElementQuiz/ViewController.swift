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
    case score
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var modeSelector: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var showAnswerButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    
// MARK: - Properties
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"] // This array will be used both as a reference for the image files in imageView and text answer in answerLabel.
    var currentElementIndex = 0 // Variable to keep track of the currently selected element.
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            
            updateUI()
        } // didSet is a **property observer** -- Everytime the value of mode is updated, the code in didSet block will run.
    } // This variable holds the information if the app is either in flashCard or quiz modes.
    var state: State = .question // This variable holds the information if the app is either showing the question or the answer in answerLabel.
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    
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
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
        }
        
        state = .question // When the next button is pressed, set the State to .question (returning from .answer which the user most likely pressed).
        
        updateUI() // After adding 1 to the currentElementIndex, the interface must be updated.
    }
    
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    
    // MARK: - Functions
    
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI(elementName: String) {
        // Text field and keyboard
        textField.isHidden = true
        textField.resignFirstResponder()
        
        // Answer label
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
        
        // Segmented control
        modeSelector.selectedSegmentIndex = 0
        
        // Buttons
        showAnswerButton.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
    } // This method is supposed to answer the question "For the current state of the app, how the UI should look?"
    
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI(elementName: String) {
        // Text field and keyboard
        textField.isHidden = false
        switch state {
        case . question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
        }
        
        // Answer label
        switch state {
        case .question:
            answerLabel.text = "" // If the quiz is asking a question, the answer label should be blank
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌\n Correct Answer: " + elementName
            }
        case .score:
            answerLabel.text = ""
        }
        
        // Score display
        if state == .score {
            displayScoreAlert()
        }
        
        modeSelector.selectedSegmentIndex = 1
        
        // Buttons
        showAnswerButton.isHidden = true
        if currentElementIndex == elementList.count - 1 {
            nextButton.setTitle("Show Score", for: .normal)
        } else {
            nextButton.setTitle("Next Question", for: .normal)
        }
        
        switch state {
        case .question:
            nextButton.isEnabled = false
        case .answer:
            nextButton.isEnabled = true
        case .score:
            nextButton.isEnabled = false
        }
        
    }
        
        
        // Updates the app's UI based on its mode and state.
        func updateUI() {
            let elementName = elementList[currentElementIndex] // This constant accesses the element name from the list using the currentElementIndex property as the index.
            let image = UIImage(named: elementName) // This line creates a new UIImage instance by looking for an image in the Asset Catalog with a matching name.
            
            imageView.image = image // This line sets the image of the image view to the newly created image instance.
            
            switch mode {
            case .flashCard:
                updateFlashCardUI(elementName: elementName)
            case .quiz:
                updateQuizUI(elementName: elementName)
            }
        } // The only method that should ever call updateFlashCardUI (and updateQuizUI) should be updateUI. All other methods will rely on updateUI when they make changes to the interface.
        
        
        // Runs after the user hits the Return Key on the keyboard
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Get the text from the text field
            let textFieldContents = textField.text!
            
            // Determine whether the user answered correctly and update appropriate quiz
            // state
            if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
                answerIsCorrect = true
                correctAnswerCount += 1
            } else {
                answerIsCorrect = false
            }
            
            // For debugging purposes
            // if answerIsCorrect {
            //     print("CORRECT")
            // } else {
            //     print("WRONG")
            // }
           
            // The app should now display the answer to the user
            state = .answer
            
            updateUI()
            
            return true
        }
    
    
    // Score alert
    func displayScoreAlert() {
        let alert = UIAlertController(title: "Quiz Score",
                                      message: "Your score is \(correctAnswerCount) out of \(elementList.count)" ,
                                      preferredStyle: .alert) // This creates a new alert.
        let dismissAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: scoreAlertDismissed(_:)) // This describes the button that will go at the bottom.
        alert.addAction(dismissAction) // Adds the action declared above to the alert also declared above.
        
        present(alert, animated: true, completion: nil)
    }
    
    // Score alert dismiss
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    
    // Sets up a new flash card session.
    func setupFlashCards() {
        state = .question
        currentElementIndex = 0
    }
    
    
    // Sets up a new quiz.
    func setupQuiz() {
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
        
        
        
        
        
        
        
        
}
