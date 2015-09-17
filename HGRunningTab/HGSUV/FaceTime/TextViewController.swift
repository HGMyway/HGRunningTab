//
//  TextViewController.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/9/16.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

class TextViewController: HGBaseViewController {

    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView?.text = text
        }
    }
    var text : String = ""{
        didSet{
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get{
            if textView != nil && presentationController != nil{
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }else
            {
                return super.preferredContentSize
            }
        }
        set{ super.preferredContentSize = newValue}
    }
}
