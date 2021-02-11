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
    
    var correctAnswer = ""
    var guessedLetters = [Character]()
    
    var currentAnswer = "" {
        didSet {
            wordLabel.text = currentAnswer
        }
    }
    
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
        submitButton.addAction(UIAction(handler: onSubmitTapped), for: .touchUpInside)
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
        
        loadGame()
    }
    
    func loadGame() {
        guard let animalsTxtUrl = Bundle.main.url(forResource: "animals", withExtension: "txt") else {
            print("No file found")
            return
        }
        
        guard let animalsTxtContent = try? String(contentsOf: animalsTxtUrl) else {
            print("Cant transform file into string")
            return
        }
        
        var possibleAnswers = animalsTxtContent.components(separatedBy: "\n")
        possibleAnswers.shuffle()
        
        correctAnswer = possibleAnswers[0]
        
        // IMPLEMENTACAO ALTERNATIVA PARA START GAME:
        // currentAnswer = String(repeating: "?", count: correctAnswer.count)
        
        updateWordLabel()
    }
    
    func updateWordLabel() {
        var newWordLabel = ""
        
        for letter in correctAnswer {
            if guessedLetters.contains(Character(letter.lowercased())) {
                newWordLabel += String(letter)
            } else {
                newWordLabel += "?"
            }
        }
        
        currentAnswer = newWordLabel
    }
    
    func onSubmitTapped(action: UIAction) {
        let alertController = UIAlertController(title: "Enter a new character", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "submit", style: .default) { [weak self, weak alertController] action in
            guard let answer = alertController?.textFields?[0].text else { return }
            
            self?.submitAnswer(answer)
        }
        
        alertController.addAction(submitAction)
        
        present(alertController, animated: true)
    }
    
    func submitAnswer(_ answer: String) {
        if answer.count > 1 {
            let errorAlert = UIAlertController(title: "Error!", message: "You can't type more than one word per try!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(errorAlert, animated: true)
            return
        }
        
        if correctAnswer.lowercased().contains(answer.lowercased()) {
            guessedLetters.append(contentsOf: answer)
            updateWordLabel()
        } else {
            numberOfTriesRemaining -= 1
            
            let wrongAnswerAlert = UIAlertController(title: "Too bad!", message: "The letter isn't in the word!", preferredStyle: .alert)
            wrongAnswerAlert.addAction(UIAlertAction(title: ":(", style: .default))
            
            present(wrongAnswerAlert, animated: true)
        }
        
        checkGameStatus()
    }
    
    func checkGameStatus() {
        if numberOfTriesRemaining == 0 {
            let endGameAlert = UIAlertController(title: "You lost!", message: "No more tries remaining", preferredStyle: .alert)
            endGameAlert.addAction(UIAlertAction(title: "Try again", style: .default))
            
            present(endGameAlert, animated: true) { [weak self] in
                self?.resetGame()
            }
        } else if (correctAnswer == currentAnswer) {
            let winGameAlert = UIAlertController(title: "Congratulations!", message: "You won the game!", preferredStyle: .alert)
            winGameAlert.addAction(UIAlertAction(title: "Play again", style: .default))
            
            present(winGameAlert, animated: true) { [weak self] in
                self?.resetGame()
            }
        }
    }
    
    func resetGame() {
        numberOfTriesRemaining = 5
        guessedLetters.removeAll()
        
        loadGame()
    }
}
