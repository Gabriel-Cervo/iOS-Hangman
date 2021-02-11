//
//  ViewController.swift
//  hangman
//
//  Created by João Gabriel Dourado Cervo on 11/02/21.
//

import UIKit

class ViewController: UIViewController {
    var wordLabel: UILabel!
    var numberOfTriesLabel: UILabel!
    
    let correctAnswer: String = "?"
    var numberOfTriesRemaining = 5 {
        didSet {
            numberOfTriesLabel.text = "\(numberOfTriesRemaining) tries remaining"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 24)
        wordLabel.text = "?"
        view.addSubview(wordLabel)
        
        numberOfTriesLabel = UILabel()
        numberOfTriesLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfTriesLabel.textAlignment = .center
        numberOfTriesLabel.font = UIFont.systemFont(ofSize: 20)
        numberOfTriesLabel.text = "\(numberOfTriesRemaining) tries remaining"
        view.addSubview(numberOfTriesLabel)
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("New letter", for: .normal)
        view.addSubview(submitButton)
            
        // testing
        numberOfTriesLabel.backgroundColor = .red
        wordLabel.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

