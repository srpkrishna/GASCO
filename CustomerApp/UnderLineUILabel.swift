//
//  UnderLineUILabel.swift
//  CustomerApp
//
//  Created by Ashok on 4/24/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class UnderLineUILabel: UILabel {

    
    override var text: String! {
        didSet {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 20
            
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
//            attributedText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: textRange)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: textRange)
            self.attributedText = attributedText
        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
