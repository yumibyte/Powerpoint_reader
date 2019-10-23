//
//  ViewController.swift
//  Powerpoint_readerc
//
//  Created by Ashley Raigosa on 10/22/19.
//  Copyright © 2019 Ashley Raigosa. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let sentence = "Hello, my name is Ashley"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("sentence to parse: ")
        
        if let answer = readLine() {
            partsOfSpeech(for: answer)
        }
    }
    
    // Initialization of NSLinguisticTagger
    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    
    // Identify Parts of Speech
    func partsOfSpeech(for text: String) {
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

