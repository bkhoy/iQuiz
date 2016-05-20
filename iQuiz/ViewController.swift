//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/5/16.
//  Copyright © 2016 Brittney. All rights reserved.
//

import UIKit

struct actualURL {
    static var targetURL = "http://tednewardsandbox.site44.com/questions.json"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizzes = [AnyObject]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func alertBox(sender: AnyObject) {
        let alertController: UIAlertController = UIAlertController(title: "Download the quiz here!", message: "Enter a quiz URL", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "http://tednewardsandbox.site44.com/questions.json"
            
        }
        
        let defaultAction = UIAlertAction(title: "Check Now", style: .Default, handler: {
            (paramAction:UIAlertAction!) in
            if let inputText = alertController.textFields {
                let textBox = inputText as [UITextField]
                let input = textBox[0].text
                if input != nil {
                    actualURL.targetURL = input!
                } else {
                    actualURL.targetURL = "http://tednewardsandbox.site44.com/questions.json"
                }
                self.tableView.reloadData()
            }
        
        })
        
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    let cellIdentifier = "CellIdentifier"

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell?
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)

        let image = UIImage(named: "icon")
        cell!.imageView?.image = image
        let title = quizzes[indexPath.row]["title"] as? String
        let desc = quizzes[indexPath.row]["desc"] as? String
        cell!.textLabel?.text = title
        cell!.detailTextLabel?.text = desc
        

        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        let newURL = "http://tednewardsandbox.site44.com/questions.json"
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let URL = NSURL(string: newURL)
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                self.quizzes = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
            } catch {
                print("There was an error...")
            }
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedQuiz = ""
    var selectedQ = [NSDictionary]()
    var quizPicked = [Array<String>()]
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedQ = (quizzes[indexPath.row]["questions"] as? [NSDictionary])!
        quizPicked.removeAll()

        for var i = 0; i < selectedQ.count; i++ {
            var currSet = [String]()
            let curQ = (selectedQ[i]["text"])!
            let curChoices = (selectedQ[i]["answers"])!
            currSet.append(curQ as! String)
            
            for var j = 0; j < curChoices.count; j++ {
                currSet.append(curChoices[j] as! String)
            }
            let answerIndex = ((selectedQ[i]["answer"])!).integerValue
            let answer1 = (curChoices[answerIndex - 1])!
            currSet.append(answer1 as! String)
            quizPicked.append(currSet)
        }
        self.performSegueWithIdentifier("ShowQuestion", sender: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? QuestionViewController {
            vc.quizzes = quizzes
            vc.quiz = quizPicked
        }
    }
    
    @IBAction func exit(segue : UIStoryboardSegue) {
        self.tableView.reloadData()
    }
}