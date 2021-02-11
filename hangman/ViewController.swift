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
        submitButton.tintColor = .black
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.titleEdgeInsets = .init(top: 10, left: 15, bottom: 10, right: 15)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            wordLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            wordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            numberOfTriesLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 25),
            numberOfTriesLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            submitButton.topAnchor.constraint(equalTo: numberOfTriesLabel.bottomAnchor, constant: 25),
            submitButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.2, constant: 75)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

