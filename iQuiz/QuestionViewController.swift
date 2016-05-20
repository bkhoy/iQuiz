//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/10/16.
//  Copyright © 2016 Brittney. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    var quizzes = [AnyObject]()
    var quiz = [Array<String>()]
    var questionNum = 0
    var selectedChoice = ""
    var correctTotal = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        questionLabel.text = quiz[questionNum][0]
    }

    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? AnswerViewController {
            vc.selectedChoice = selectedChoice
            vc.correctAnswer = quiz[questionNum][5]
            vc.quiz = quiz
            vc.questionNum = questionNum
            vc.correctTotal = correctTotal
        }
    }

    @IBAction func choiceSelected(sender: UIButton) {
        self.performSegueWithIdentifier("ShowAnswer", sender: nil)
    }
    
    let cellIdentifier = "CellIdentifier"
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)

        cell!.textLabel?.text = quiz[questionNum][indexPath.row + 1]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedChoice = (currCell?.textLabel?.text)!
    }
}
