//
//  ViewController.swift
//  TimeLineDemo
//
//  Created by Haven on 2016-06-07.
//  Copyright © 2016 Haven. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var topLine: UIView!
    var bottomLine: UIView!
    var leadingSpaceOfLines: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "TimeLineCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "TimeLineCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor = UIColor.clearColor()
        
        topLine = UIView()
        topLine.backgroundColor = UIColor.orangeColor()
        bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.grayColor()
        view.addSubview(topLine)
        view.addSubview(bottomLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        didScroll()
    }

    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 67
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let _cell = cell as? TimeLineCell {
            topLine.backgroundColor = _cell.topLine.backgroundColor;
            leadingSpaceOfLines = _cell.convertPoint(_cell.topLine.frame.origin, toView: view).x
        }
        
        didScroll();
    }
    
    func didScroll() {
        topLine.frame = CGRect(x: leadingSpaceOfLines, y: 0, width: 2, height: -tableView.contentOffset.y)
        
        let offsetY = tableView.frame.height - tableView.contentSize.height + tableView.contentOffset.y
        bottomLine.frame = CGRect(x: leadingSpaceOfLines, y: view.frame.height - offsetY, width: 2, height: view.frame.height)
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeLineCell") as! TimeLineCell
        cell.bottomLine.backgroundColor = indexPath.row == 2 ? UIColor.grayColor() : topLine.backgroundColor
        cell.selectionStyle = .None
        return cell
    }
}

