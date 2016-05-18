//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/5/16.
//  Copyright © 2016 Brittney. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func alertBox(sender: AnyObject) {
        let alertController: UIAlertController = UIAlertController(title: "Settings go here", message: "Hello", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    var titles = ["Mathematics", "Marvel Super Heroes", "Science"]
    var descriptors = ["What is Math?", "What is Marvel?", "What is Science?"]
    var images = [UIImage(named: "math"), UIImage(named: "marvel"), UIImage(named: "science")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CategoryCells
        
        cell.photo.image = images[indexPath.row]
        cell.title.text = titles[indexPath.row]
        cell.describe.text = descriptors[indexPath.row]
        
        return cell
    }
}


