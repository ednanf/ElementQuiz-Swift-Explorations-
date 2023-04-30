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
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0 // Variable to keep track of the currently selected element.
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateElement()
    }
    
// MARK: - IBActions
    
    @IBAction func showAnswer(_ sender: Any) {
    }
    
    
    @IBAction func next(_ sender: Any) {
    }
    
    
// MARK: - Functions
    
    func updateElement() {
        let elementName = elementList[currentElementIndex] // This constant accesses the element name from the list using the currentElementIndex property as the index.
        let image = UIImage(named: elementName) // This line creates a new UIImage instance by looking for an image in the Asset Catalog with a matching name.
        imageView.image = image // This line sets the image of the image view to the newly created image instance.
        
        answerLabel.text = "?" // This line sets the text of the answer label (using the text property of the UILabel type) to a question mark.
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
