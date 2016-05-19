//
//  ColumnDisplayView.swift
//  Chart
//
//  Created by Phani on 17/11/15.
//  Copyright © 2015 MetricStream. All rights reserved.
//

import UIKit

class ColumnDisplayView: DisplayView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var barSpace:CGFloat = 0
    var maxBarWidth:CGFloat = 0
    
    var popupWidth: CGFloat = 0
    var popupHeight: CGFloat = 0
    
    override func layoutSubviews() {
        self.drawChart();
    }
    
    func drawChart()
    {
        
        setSize()
        
        let xUnit = (self.frame.size.width)/CGFloat(self.xAxisKeys.count)
        let yUnit = (self.frame.size.height)/(highValue-lowValue)
        
        for (xIndex, xKey) in self.xAxisKeys.enumerate()
        {
            
            var barWidth = (xUnit-barSpace)/CGFloat(self.colorKeys.count)
            
            if(barWidth>maxBarWidth)
            {
                barWidth = maxBarWidth
            }
            
            if let pointsAtXKey = self.data[xKey]
            {
            
                for (colorIndex, colorKey) in self.colorKeys.enumerate()
                {
                
                    let x = xUnit * CGFloat(xIndex) + (xUnit - (barWidth*CGFloat(self.colorKeys.count)))/2 + barWidth * CGFloat(colorIndex)
                    
                    if let chartUnit = pointsAtXKey[colorKey]
                    {
                    
                        let barHeight = chartUnit.value * yUnit
                        
                        let y = self.frame.size.height - barHeight
                        
                        let viewIndex = barViewIndex+(xIndex*self.colorKeys.count) + colorIndex
                        
                        if let view = self.viewWithTag(viewIndex)
                        {
                            view.frame = CGRectMake(x, y, barWidth, barHeight)
                            
                        }else
                        {
                            let view = UIView.init(frame: CGRectMake(x, y, barWidth, barHeight))
                            
                            let index = colorIndex % colors.count
                            view.backgroundColor = colors[index]
                            view.tag = viewIndex
                            self.addSubview(view)
                            
                            let touch = UITapGestureRecognizer.init(target: self, action: "tapped:")
                            touch.delegate = self;
                            view.addGestureRecognizer(touch);
                            
                        }
                    }
                                        
                }
            }
        }
    }
    
    func tapped(recognizer:UITapGestureRecognizer)
    {
        let viewIndex = (recognizer.view?.tag)! - barViewIndex;
        let axisIndex = viewIndex/self.colorKeys.count;
        let colorIndex = viewIndex % self.colorKeys.count;
        let axisKey = self.xAxisKeys[axisIndex];
        let colorKey = self.colorKeys[colorIndex];
        
        let width = recognizer.view?.frame.size.width;
        
        if let pointsAtXKey = self.data[axisKey]
        {
            if let chartUnit = pointsAtXKey[colorKey]
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("popup") as UIViewController
                
                vc.modalPresentationStyle = UIModalPresentationStyle.Popover
                vc.preferredContentSize = CGSizeMake(self.popupWidth, self.popupHeight)
                vc.popoverPresentationController?.sourceRect = CGRect(x: (width!/2), y: 1, width:0, height:0);
                vc.popoverPresentationController?.sourceView = recognizer.view;
                
                
                let popupView:PopupView = vc.view as! PopupView;
                popupView.header1?.text = xAxisName;
                popupView.header2?.text = chartUnit.colorName;
                popupView.label1?.text = chartUnit.xname;
                popupView.label2?.text = String(chartUnit.value);
                
                let index = colorIndex % colors.count
                popupView.header1?.textColor = colors[index]
                popupView.header2?.textColor = colors[index]
                
                delegate?.showPopup(vc);
                
            }
        }
    
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        
        if let path = NSBundle.mainBundle().pathForResource("Size", ofType: "plist"),
            dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                
                let iPhoneComponents = dict[deviceType.model] as? Dictionary<String, AnyObject>
                let componentSizes = iPhoneComponents!["ColumnDisplayView"] as? Dictionary<String, AnyObject>
                let maxbarWidth: Int = (componentSizes!["maxBarWidth"] as? Int)!
                let barSpace: Int = (componentSizes!["barSpace"] as? Int)!
                
                self.maxBarWidth = CGFloat(maxbarWidth)
                self.barSpace = CGFloat(barSpace)
                
                 let popupComponentSizes = iPhoneComponents!["PopupView"] as? Dictionary<String, AnyObject>
                let tempPopupWidth: Int = (popupComponentSizes!["popupWidth"] as? Int)!
                let tempPopupHeight: Int = (popupComponentSizes!["popupHeight"] as? Int)!
                
                self.popupWidth =  CGFloat(tempPopupWidth)
                self.popupHeight = CGFloat(tempPopupHeight)
                
                print("tempPopupWidth = \(popupWidth))")
                print("tempPopupHeight = \(popupHeight))")

                
        }
    }
    
    let barViewIndex = 1000;
}
