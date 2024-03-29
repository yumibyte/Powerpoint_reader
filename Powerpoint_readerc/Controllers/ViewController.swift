//
//  ViewController.swift
//  Powerpoint_readerc
//
//  Created by Ashley Raigosa on 10/22/19.
//  Copyright © 2019 Ashley Raigosa. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var textFieldInput: UITextField!
    
    let sentence = "Hello, my name is Ashley"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        self.hideKeyboardWhenTappedAround()
    }

    // Click button to give question (run partsOfSpeech())
//MARK: - Firebase data manipulation
    @IBAction func partsOfSpeechButton(_ sender: Any) {
        
        // Make sure textField != nil
        if let text = textFieldInput.text {
            // Upload sentence into Firebase database
            let flashCardDB = Database.database().reference().child("Flashcards")
            
            let flashCardDictionary = ["Term": text,
                                       "Definition": "test"] as [String : Any]
            flashCardDB.childByAutoId().setValue(flashCardDictionary) {
                    (error, reference) in
                    
                    if error != nil {
                        print(error!)
                    } else {
                        print("Message saved successfully!")
                        
                    }
            }
            // put textField input into language parser
            partsOfSpeech(for: text)
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func mySetButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToMySet", sender: self)
    }
    
//MARK: - Functionality for creating set
    func partsOfSpeech(for text: String) {
        // Initialization of NSLinguisticTagger
        let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        // Identifying parts of speech
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                print("\(word): \(tag.rawValue)")
            }
        }
        
    }
       
}

//MARK: - Extension for keyboard manipulation
// Dismiss keyboard when return is clicked
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
