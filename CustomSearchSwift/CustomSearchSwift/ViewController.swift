//
//  ViewController.swift
//  CustomSearchSwift
//
//  Created by bhliu on 14-6-16.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SearchViewDelegate {
    
    var searchView:CustomSearchView!
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.searchView = CustomSearchView(frame: CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(self.searchView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectOnResult(result:NSDictionary) {
        //do something
    }
}

