//
//  CustomSearchView.swift
//  CustomSearchSwift
//
//  Created by bhliu on 14-6-16.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func selectOnResult(result:NSDictionary)
}

class CustomSearchView: UIView,UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource,KeyWordDelegate {

    var resultTable: UITableView!
    var resultArray: NSArray!
    var searchBar: UISearchBar!
    var keywordView:HotKeywordsView!
    var delegate: SearchViewDelegate?
    
    let kCellIdentifier: String = "SearchResultCell"
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.resultArray = NSArray()
        self.backgroundColor = UIColor(red: 240.0/256, green: 240.0/256, blue: 240.0/256, alpha: 1.0)
        
        self.searchBar = UISearchBar(frame: CGRectMake(0.0, 0.0, self.bounds.size.width, 44.0))
        self.searchBar.placeholder = "Search for anything..."
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.addSubview(self.searchBar)
        
        self.resultTable = UITableView(frame: CGRectMake(0, 44, self.bounds.size.width, 170))
        self.resultTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.resultTable.delegate = self
        self.resultTable.dataSource = self
        self.resultTable.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.resultTable.backgroundColor = UIColor(red: 240.0/256, green: 240.0/256, blue: 240.0/256, alpha: 1)
        self.resultTable.hidden = true
        self.addSubview(self.resultTable)
        
        self.keywordView = HotKeywordsView(frame: CGRectMake(0, 54, self.bounds.size.width, 170))
        keywordView.delegate = self
        self.addSubview(self.keywordView)
        self.keywordView.setWords(NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("keywords", ofType: "json")), options:nil, error: nil) as NSArray)
    }
    

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return 5 // test only
        return self.resultArray!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        
        cell.textLabel.text = "search result here";
        
        return cell
    }
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 30.0
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if self.delegate {
            self.delegate!.selectOnResult(self.resultArray[indexPath.row] as NSDictionary)
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar!) -> Bool {
        return true
    }
    
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        if searchText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            self.resultTable.hidden = true
            return
        }
        
        self.searchBar.becomeFirstResponder()
        if self.resultTable.hidden {
            self.resultTable.hidden = false
        }
        self.resultTable.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        self.searchBar.resignFirstResponder()
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { self.frame = CGRectMake(0, 2*self.superview.frame.size.height, self.frame.size.width, self.frame.size.height) }, completion: { value in })
    }
    
    func selectOnKeyWord(word: NSString) {
        self.searchBar.text = word
    }
    
}
