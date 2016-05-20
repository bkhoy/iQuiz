//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/10/16.
//  Copyright © 2016 Brittney. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    var questionNum = 0
    var correctTotal = 0
    var quizzes = [AnyObject]()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        scoreLabel.text = "You got \(String(correctTotal)) out of \(String(questionNum)) correct"
        
        let percentCorrect = Double(correctTotal)/Double(questionNum)

        if percentCorrect == 1 {
            messageLabel.text = "Perfect!"
        } else if percentCorrect >= 0.8 {
            messageLabel.text = "Almost!"
        } else if percentCorrect >= 0.6 {
            messageLabel.text = "Not bad!"
        } else {
            messageLabel.text = "That was terrible..."
        }
        
    }
    
    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ViewController {
            vc.quizzes = quizzes
        }
    }
    
    @IBAction func nextSelected(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowQuizzes", sender: nil)
    }

}
