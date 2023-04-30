//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Ednan R. Frizzera Filho on 30/04/23.
//

import UIKit

class ViewController: UIViewController {

// MARK: - IBOutlets
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    
    
// MARK: - Properties
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"] // This array will be used both as a reference for the image files in imageView and text answer in answerLabel.
    var currentElementIndex = 0 // Variable to keep track of the currently selected element.
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateElement()
    }
    
// MARK: - IBActions
    
    @IBAction func showAnswer(_ sender: Any) {
        answerLabel.text = elementList[currentElementIndex]
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1 // Since we access items in an array by index, we can calculate the value of the next element by adding 1 to the current index.
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
        } // This if statement prevents the app crashing for going out of range. If the index's number is equal to currentElementIndex, it will simply set it back to 0, causing a loop.
        
        updateElement() // After adding 1 to the currentElementIndex, the interface must be updated.
    }
    
    
// MARK: - Functions
    
    func updateElement() {
        let elementName = elementList[currentElementIndex] // This constant accesses the element name from the list using the currentElementIndex property as the index.
        let image = UIImage(named: elementName) // This line creates a new UIImage instance by looking for an image in the Asset Catalog with a matching name.
        imageView.image = image // This line sets the image of the image view to the newly created image instance.
        
        answerLabel.text = "?" // This line sets the text of the answer label (using the text property of the UILabel type) to a question mark.
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
