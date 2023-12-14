//
//  ViewController.swift
//  nlite
//
//  Created by Rebecca Sweigart on 11/29/23.
//
// The following was referenced:
//  Andrew at Seemu Apps (https://www.seemuapps.com/swift-make-a-trivia-quiz-game) for the base quiz mechanics
// Saamer Mansoor at freeCodeCamp (https://www.freecodecamp.org/news/how-to-implement-a-leaderboard-in-swiftui/#:~:text=Once%20you%20have%20created%20the,based%20on%20your%20frequency%20settings).) for the leaderboard set up

import SwiftUI
import UIKit
import GameKit
import CoreImage.CIFilterBuiltins


class ViewController: UIViewController {
    
    
// questions and answers for the quiz
    struct Question {
            let question: String
            let answers: [String]
            let correctAnswer: Int
        }
    
    var questions: [Question] = [
            Question(
                question: "What is the contraction for: Are not?",
                answers: ["Arent", "Aren't", "Arn't", "Arent'"],
                correctAnswer: 1),
            Question(
                question: "What is the contraction for: There is?",
                answers: ["There's", "Theres", "Their's", "Theres'"],
                correctAnswer: 0),
            Question(
                question: "What is the contraction for: It is?",
                answers: ["Its", "Its'", "It is", "It's"],
                correctAnswer: 3),
            Question(
                question: "What is the contraction for: I am?",
                answers: ["I'm", "Im", "Iam", "I'am"],
                correctAnswer: 0),

            Question(
                question: "What is the contraction for: You will?",
                answers: ["You're", "You'll", "Youwill", "You'will"],
                correctAnswer: 1),

            Question(
                question: "What is the contraction for: We have?",
                answers: ["We're", "Weve", "We've", "We'have"],
                correctAnswer: 2),

            Question(
                question: "What is the contraction for: They are?",
                answers: ["They're", "They'll", "Theyare", "They'are"],
                correctAnswer: 0),

            Question(
                question: "What is the contraction for: Can not?",
                answers: ["Cannot", "Can't", "Cant", "Can'not"],
                correctAnswer: 1),

            Question(
                question: "What is the contraction for: Will not?",
                answers: ["Willnot", "Won't", "Willn't", "Will'not"],
                correctAnswer: 1),

            Question(
                question: "What is the contraction for: I will?",
                answers: ["Iwill", "I'll", "Ill", "I'will"],
                correctAnswer: 1),
        ]
        
        var currentQuestion: Question?
        var currentQuestionPos = 0
        var noCorrect = 0
    

// connecting the buttons to the code
    @IBOutlet weak var lblQuestion: UITextView!
    
    @IBOutlet weak var Answer0: UIButton!
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    
    @IBOutlet weak var lblProgress: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        setQuestion()
    }
    
    @IBAction func submitAnswer0(_ sender: Any) {
        checkAnswer(idx: 0)
    }
    @IBAction func submitAnswer1(_ sender: Any) {
        checkAnswer(idx: 1)
    }
    @IBAction func submitAnswer2(_ sender: Any) {
        checkAnswer(idx: 2)
    }
    @IBAction func submitAnswer3(_ sender: Any) {
        checkAnswer(idx: 3)
    }
    
    // Check if an answer is correct then load the next question
        func checkAnswer(idx: Int) {
            if(idx == currentQuestion!.correctAnswer) {
                noCorrect += 1
            }
            loadNextQuestion()
        }
        
    func loadNextQuestion() {
    // Show next question
    if(currentQuestionPos + 1 < questions.count) {
    currentQuestionPos += 1
    currentQuestion = questions[currentQuestionPos]
    setQuestion()
    // If there are no more questions show the results
    } else {
      //  performSegue(withIdentifier: "sgShowResults", sender: nil)
        showQuizResults()
        
    }
    

    }
    
    // Set labels and buttions for the current question
    func setQuestion() {
        lblQuestion.text = currentQuestion!.question
        Answer0.setTitle(currentQuestion!.answers[0], for: .normal)
        Answer1.setTitle(currentQuestion!.answers[1], for: .normal)
        Answer2.setTitle(currentQuestion!.answers[2], for: .normal)
        Answer3.setTitle(currentQuestion!.answers[3], for: .normal)
        lblProgress.text = "\(currentQuestionPos + 1) / \(questions.count)"
    }

    func generateQRCode(from string: String) -> UIImage? {
            let context = CIContext()
            let filter = CIFilter.qrCodeGenerator()

            guard let data = string.data(using: .utf8) else { return nil }
            filter.setValue(data, forKey: "inputMessage")

            if let qrCodeImage = filter.outputImage {
                let cgImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent)
                return UIImage(cgImage: cgImage!)
            }

            return nil
        }

    func showQuizResults() {
        let resultsString = "Quiz Results: \(noCorrect)/\(questions.count)"
        let qrCodeImage = generateQRCode(from: resultsString)

        // Display the results and QR code in ResultsViewController
        let resultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        resultsViewController.noCorrect = noCorrect
        resultsViewController.total = questions.count
        resultsViewController.resultsString = resultsString
        resultsViewController.qrCodeImage = qrCodeImage

        present(resultsViewController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgShowResults") {
            let vc = segue.destination as! ResultsViewController
            vc.noCorrect = noCorrect
            vc.total = questions.count
        }
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}

extension UIAlertController {
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 245, height: 300)
        let imageSize = image.size
        var ratio: CGFloat!

        if imageSize.width > imageSize.height {
            ratio = maxSize.width / imageSize.width
        } else {
            ratio = maxSize.height / imageSize.height
        }

        let scaledSize = CGSize(width: imageSize.width * ratio, height: imageSize.height * ratio)
        let resizedImage = image.imageWithSize(scaledSize)

        let imageView = UIImageView(image: resizedImage)
        self.view.addSubview(imageView)
    }
}

extension UIImage {
    func imageWithSize(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
