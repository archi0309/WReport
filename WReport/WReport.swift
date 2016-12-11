//
//  WReport.swift
//  WReport
//
//  Created by Kochi Lin on 12/11/16.
//  Copyright © 2016 Kochi Lin. All rights reserved.
//

import UIKit

@IBDesignable
class WReport: UIView {
  var graphPoints:[Int] = [40, 29, 3, 0, 5, 100, 9]
  var YLabel:[Int] = [0, 20, 40, 60, 80, 100].reverse()
  let calendar = NSCalendar.currentCalendar()
  let now = NSDate.init()
  let lineColor  = UIColor.lightGrayColor()
  let lblNumColor = UIColor.purpleColor()
  override func drawRect(rect: CGRect) {
    let width = rect.width
    let height = rect.height
    //TODO: Change to theme gery color
    
    let margin:CGFloat = 30.0
    let columnXPoint = { (column:Int) -> CGFloat in
      //Calculate gap between points
      let spacer = (width - margin*2 - 4) /
        CGFloat((self.graphPoints.count - 1))
      var x:CGFloat = CGFloat(column) * spacer
      x += margin + 2
      return x
    }
    
    
    let topBorder:CGFloat = 50
    let bottomBorder:CGFloat = 50
    let graphHeight = height - topBorder - bottomBorder
    
    let maxValue = graphPoints.maxElement()
    let columnYPoint = { (graphPoint:Int) -> CGFloat in
      var y:CGFloat = CGFloat(graphPoint) /
        CGFloat(maxValue!) * graphHeight
      y = graphHeight + topBorder - y
      return y
    }
    
    
    // draw the line graph
    lineColor.setFill()
    lineColor.setStroke()
    
    let topLine  = UIBezierPath()
    topLine.moveToPoint(CGPoint(x: topBorder/2, y: 0))
    topLine.addLineToPoint(CGPoint(x: rect.width, y: 0))
    topLine.lineWidth = 1
    topLine.stroke()
    
    let bottomLine  = UIBezierPath()
    bottomLine.moveToPoint(CGPoint(x: topBorder/2, y: rect.height-40))
    bottomLine.addLineToPoint(CGPoint(x: rect.width, y:rect.height-40))
    bottomLine.lineWidth = 1
    bottomLine.stroke()
    
    //set up the points line
    let graphPath = UIBezierPath()
    //go to start of line
    graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
      y:columnYPoint(graphPoints[0])))
    
    for i in 1..<graphPoints.count {
      let nextPoint = CGPoint(x:columnXPoint(i),
                              y:columnYPoint(graphPoints[i]))
      graphPath.addLineToPoint(nextPoint)
    }
    
    graphPath.stroke()

    for i in 0..<YLabel.count{
      //y label
      let lblY = UILabel()
      let lblYHeight:CGFloat = 20
      lblY.frame  = CGRectMake(0, columnYPoint(YLabel[i])-lblYHeight/2 , 40, lblYHeight)
      lblY.text = String(YLabel[i])
      lblY.adjustsFontSizeToFitWidth = true
      lblY.textAlignment = .Justified
    //  lblY.backgroundColor =  UIColor.cyanColor()
      self.addSubview(lblY)
    }
    
    //Draw the circles on top of graph stroke
    
    for i in 0..<graphPoints.count {
      var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
      point.x -= 5.0/2
      point.y -= 5.0/2
      
      let circle = UIBezierPath(ovalInRect:
        CGRect(origin: point, size: CGSize(width: 6.0, height: 6.0)))
      circle.fill()
      //number label
      let lblNumber = UILabel()
      lblNumber.frame  = CGRectMake(point.x, point.y-20, 25, 20)
      lblNumber.text = String(graphPoints[i])
      lblNumber.adjustsFontSizeToFitWidth = true
      lblNumber.textAlignment = .Justified
      lblNumber.textColor = lblNumColor
      
    //  lblNumber.backgroundColor =  UIColor.brownColor()
      
      
      
      let components = calendar.components([.Year, .Month , .Day], fromDate: now)
      components.day = components.day - 6 + i
      let date = calendar.dateFromComponents(components)
      let formatter = NSDateFormatter()
      formatter.locale = NSLocale(localeIdentifier:"zh_Hant_TW")
      formatter.timeZone = NSTimeZone.defaultTimeZone()
      
      //day label
      let lblweekday = UILabel()
      lblweekday.frame  = CGRectMake(point.x, rect.height-40, 25, 20)
      
      formatter.dateFormat = "M/dd"
      lblweekday.adjustsFontSizeToFitWidth = true
      lblweekday.text = formatter.stringFromDate(date!)
      lblweekday.textAlignment = .Justified
     // lblweekday.backgroundColor =  UIColor.blueColor()
      
      //TW Day label
      let lblDate = UILabel()
      formatter.dateFormat = "EEEE"
      lblDate.frame  = CGRectMake(point.x, rect.height-20, 25, 20)
      lblDate.text = formatter.stringFromDate(date!)
      lblDate.adjustsFontSizeToFitWidth = true
      lblDate.textAlignment = .Justified
     // lblDate.backgroundColor =  UIColor.darkGrayColor()
      
      formatter.dateFormat = "c"
      
      switch formatter.stringFromDate(date!)  {
      case "1":
        lblDate.textColor = UIColor.redColor()
      case "7":
        lblDate.textColor = UIColor.greenColor()
      default:
        lblDate.textColor = lineColor
      }
      
      self.addSubview(lblNumber)
      self.addSubview(lblDate)
      self.addSubview(lblweekday)
    }
    
  }
  
  
  
}
