//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/10/16.
//  Copyright © 2016 Brittney. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!
    
    var selectedChoice = ""
    var correctAnswer = ""
    var quizzes = [AnyObject]()
    var quiz = [Array<String>()]
    var questionNum = 0
    var correctTotal = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        questionLabel.text = quiz[questionNum][0]
        choiceLabel.text = "Your Answer: \(selectedChoice)"
        answerLabel.text = "Correct Answer: \(correctAnswer)"
        
        // Check if selected choice is the correct answer
        if selectedChoice == correctAnswer {
            indicatorLabel.text = "You are correct!"
            correctTotal++
        } else {
            indicatorLabel.text = "You are incorrect."
        }
        
        questionNum++
    }

    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextSelected(sender: AnyObject) {
        // If no more questions to ask
        if questionNum == quiz.count {
            self.performSegueWithIdentifier("ShowFinished", sender: nil)
        } else {
            self.performSegueWithIdentifier("ShowQuestion", sender: nil)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if questionNum < quiz.count {
            if let vc = segue.destinationViewController as? QuestionViewController {
                vc.questionNum = questionNum
                vc.quiz = quiz
                vc.correctTotal = correctTotal
                vc.quizzes = quizzes
            }
        } else {
            if let vc = segue.destinationViewController as? FinishedViewController {
                vc.questionNum = questionNum
                vc.correctTotal = correctTotal
                vc.quizzes = quizzes
            }
        }
    }

}
