//
//  HotKeywordsView.swift
//  CustomSearchSwift
//
//  Created by bhliu on 14-6-16.
//  Copyright (c) 2014 Katze. All rights reserved.
//

import UIKit

protocol KeyWordDelegate {
    func selectOnKeyWord(word:NSString)
}

class HotKeywordsView: UIView {
    
    let TOPMARGIN = 44
    let MARGIN = 10
    
    var delegate:KeyWordDelegate?
    var titleLabel:UILabel!

    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.backgroundColor = UIColor(red: 240.0/256, green: 240.0/256, blue: 240.0/256, alpha: 1.0)
        
        self.titleLabel = UILabel(frame: CGRectMake(15, 10, 200, 20))
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.text = "Popular searches";
        self.titleLabel.textColor = UIColor(red: 90.0/256, green: 90.0/256, blue: 90.0/256, alpha: 1)
        self.titleLabel.font = UIFont(name: "Arial", size: 15)
        self.titleLabel.shadowColor = UIColor.whiteColor()
        self.titleLabel.shadowOffset = CGSizeMake(0, 1)
        self.addSubview(self.titleLabel)
    }
    
    func setWords(words:NSArray) {
        var i:Int = 0
        var frameOfLastButton:CGRect = CGRectZero
        
        for dict:AnyObject in words {
            
            let tmp:NSDictionary = (dict as? NSDictionary)!
            
            let label: UILabel = UILabel(frame: CGRectMake(10, TOPMARGIN+i*25 , 70, 20))
            label.font = UIFont(name: "GillSans", size: 16)
            label.text = tmp["name"] as NSString
            label.textColor = UIColor(red: 149.0/256, green: 149.0/256, blue: 149.0/256, alpha: 1)
            label.shadowColor = UIColor.whiteColor()
            label.shadowOffset = CGSizeMake(0, 1)
            self.addSubview(label)
            
            var j:Int = 0
            for keyword:AnyObject in  (tmp["words"] as NSArray){
                
                let button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
                button.setTitle(keyword as NSString, forState: UIControlState.Normal)
                button.setTitleColor(UIColor(red: 66.0/256, green: 66.0/256, blue: 66.0/256, alpha: 1),forState: UIControlState.Normal)
                button.titleLabel.font = UIFont(name: "GillSans", size: 14)
                button.setTitleShadowColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                button.titleShadowOffset = CGSizeMake(0, 1)
                
                let size:CGSize = (keyword as NSString).sizeWithFont(UIFont.systemFontOfSize(14))
                if j != 0 {
                    button.frame = CGRectMake(frameOfLastButton.origin.x + frameOfLastButton.size.width + MARGIN, TOPMARGIN+i*25 , size.width, size.height)
                }
                else {
                    button.frame = CGRectMake(70, TOPMARGIN+i*25, size.width, size.height);
                }
                self.addSubview(button)
                
                button.addTarget(self, action: "buttonPress:", forControlEvents: UIControlEvents.TouchUpInside)
                
                j++
                frameOfLastButton = button.frame
                
            }
            
            i++;
            frameOfLastButton = CGRectZero
        }
        
    }
    
    func buttonPress(sender: UIButton!) {
        delegate?.selectOnKeyWord(sender.titleLabel.text)
    }

}
