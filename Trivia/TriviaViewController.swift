//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Kiahna Isadore on 3/11/24.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var currentQ: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    
    @IBOutlet weak var answerChoice1: UIButton!
    @IBOutlet weak var answerChoice2: UIButton!
    @IBOutlet weak var answerChoice3: UIButton!
    @IBOutlet weak var answerChoice4: UIButton!
    
    struct Question {
        let questionNumber: String
        let subject: String
        let questionText: String
        let answers: [String]
        let correctAnswerIndex: Int
    }
    
    let questions: [Question] = [
        Question(questionNumber: "Question: 1/5",
                 subject: "History",
                 questionText: "Who was the first president of the United States?",
                 answers: ["Thomas Jefferson", "John Adams", "George Washington", "Barack Obama"],
                 correctAnswerIndex: 2),
        
        Question(questionNumber: "Question: 2/5",
                 subject: "Astronomy",
                 questionText: "Which planet is the largest rocky planet in our solar system?",
                 answers: ["Earth", "Mars", "Venus", "Mercury"],
                 correctAnswerIndex: 0),
        
        Question(questionNumber: "Question: 3/5",
                 subject: "Geography",
                 questionText: "Which is the longest river in the world",
                 answers: ["Amazon River", "Nile River", "Yangtze River", "Mississippi River"],
                 correctAnswerIndex: 1),
        
        Question(questionNumber: "Question: 4/5",
                 subject: "Math",
                 questionText: "What is the value of pi (π) to two decimal places",
                 answers: ["3.14", "3.21", "3.27", "3.33"],
                 correctAnswerIndex: 0),
        
        Question(questionNumber: "Question: 5/5",
                 subject: "General Knowledge",
                 questionText: "What is the currency of Japan?",
                 answers: ["Won", "Yuan", "Yen", "Ringgit"],
                 correctAnswerIndex: 2)
    ]
    
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerChoice1.layer.cornerRadius = 20
        self.answerChoice2.layer.cornerRadius = 20
        self.answerChoice3.layer.cornerRadius = 20
        self.answerChoice4.layer.cornerRadius = 20
        self.questionLabel.layer.cornerRadius = 58
        
        displayCurrentQuestion()
    }
    
    func displayCurrentQuestion() {
        if currentQuestionIndex < 0 || currentQuestionIndex >= questions.count {
            print("Invalid currentQuestionIndex. Resetting to 0.")
            currentQuestionIndex = 0
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        currentQ.text = currentQuestion.questionNumber
        topicLabel.text = currentQuestion.subject
        questionLabel.text = currentQuestion.questionText
        answerChoice1.setTitle(currentQuestion.answers[0], for: .normal)
        answerChoice2.setTitle(currentQuestion.answers[1], for: .normal)
        answerChoice3.setTitle(currentQuestion.answers[2], for: .normal)
        answerChoice4.setTitle(currentQuestion.answers[3], for: .normal)
    }
    
    func showGameOverPopup() {
            let alertController = UIAlertController(title: "Game Over :(", message: "Final Score \(score)/5", preferredStyle: .alert)

            let resetAction = UIAlertAction(title: "Reset", style: .default) { [weak self] _ in
                self?.resetGame()
            }

            alertController.addAction(resetAction)

            present(alertController, animated: true, completion: nil)
        }

        func resetGame() {
            currentQuestionIndex = 0
            score = 0
            displayCurrentQuestion()
        }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        
        if sender.title(for: .normal) == currentQuestion.answers[currentQuestion.correctAnswerIndex] {
            score += 1
        }
        currentQuestionIndex += 1
        if currentQuestionIndex >= questions.count {
            showGameOverPopup()
        } else{
            displayCurrentQuestion()
        }
    }
}
