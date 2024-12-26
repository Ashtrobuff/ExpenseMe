//
//  CustomGraphView.swift
//  ExpenseMe
//
//  Created by Ashish on 21/12/24.
//

import UIKit
enum Constant{
    static let border=20.0
}
class CustomGraphView: UIView {
    var plotPoints:[Float]=[100,200,300,400,100,600,700,799,800,900,1000,200]
    var uprange:Int=11
    override func draw(_ rect: CGRect) {
        let scale=(rect.height-2*Constant.border)/1000
        let padding=CGFloat((Int(rect.width)/uprange+1)-2)
        var Xpon={ (point:Int)->CGFloat in
            var xcon=(padding * CGFloat(point))-5
            return xcon
            
        }
        
        var Ypon={ (point:Int)->CGFloat in
            var ycon=CGFloat(point)*scale
            return rect.height-ycon-Constant.border
        }
       
        guard let context=UIGraphicsGetCurrentContext()else{return}
        self.backgroundColor=UIColor.red

        let rectangle=CGRect(x:0, y: rect.height-Constant.border, width: rect.width, height: 1)
        
        let r1=UIBezierPath(rect: rectangle)
        let rectangle1=CGRect(x:Constant.border-10, y:0 , width: 1, height: rect.height)
     //   context.addRect(rectangle1)
        
        UIColor.white.setFill()
        UIColor.black.setStroke()
        r1.fill()
        //context.addRect(rectangle)
     //   context.drawPath(using: .fillStroke)
        for i in 0...uprange
        {           let  label=UILabel(frame: CGRect(x:Xpon(i+1)-5, y: rect.height-Constant.border+20, width: 20, height: 20))
            label.text=getMonthName(from: i+1)
            label.adjustsFontSizeToFitWidth=true
            label.textColor=UIColor.lightGray.withAlphaComponent(0.5)
            let circle=UIBezierPath(ovalIn: CGRect(x: Xpon(i+1)-10, y: rect.height-Constant.border-3, width: 6, height: 6))
            addSubview(label)
            UIColor.white.setFill()
            circle.fill()
           // context.addPath(circle.cgPath)
        }
        for i in 1...5{
            let padding=(rect.height-Constant.border)/4
            let rec=UIBezierPath(rect: CGRect(x:(padding*Double(i)),y:0,width:0.9,height:rect.height))
            UIColor.gray.withAlphaComponent(0.3).setFill()
            rec.fill()
        }
        for i in 1...5{
            let padding=(rect.width-Constant.border)/5
            let rec=UIBezierPath(rect: CGRect(x:0,y:(padding*Double(i)),width:rect.width,height:0.9))
            UIColor.gray.withAlphaComponent(0.3).setFill()
            rec.fill()
        }

        let path=UIBezierPath()
        path.move(to: CGPoint(x:Xpon(1),y:Ypon(Int(plotPoints[0])))
                  )
        path.lineWidth=2
        UIColor.white.setStroke()
        // PLOTTING THE POINTS AND LINE//
        for i in  0...uprange
        {
            let scale=12/rect.height-Constant.border
            path.addLine(to: CGPoint(x:Xpon(i+1),y:Ypon(Int(plotPoints[i]))))
            let circle1=UIBezierPath(ovalIn: CGRect(x:Xpon(i+1)-3,y:Ypon(Int(plotPoints[i]))-3,width:6,height:6))
            UIColor(r:255,g:45,b:85).setStroke()
            UIColor(r:255,g:45,b:85).setFill()
            circle1.fill()
            path.stroke()
            context.addPath(circle1.cgPath)
        }
     context.saveGState()
        guard let clippingPath=(path.copy() as? UIBezierPath) else {return}

        clippingPath.addLine(to: CGPoint(x: Xpon(12), y: rect.height))
        clippingPath.addLine(to:CGPoint(x: Xpon(1), y:rect.height))
        clippingPath.close()
        clippingPath.addClip()
   ////     UIColor.blue.setFill()
     ///   let rect=UIBezierPath(rect:rect)
     //   rect.fill()
        
        let highestpoint=Ypon(Int(plotPoints.max()!))
        let startpoint=CGPoint(x: 20, y: highestpoint)
        let endpoint=CGPoint(x:20,y:bounds.height)
        let gradient1=CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [UIColor(r:247,g:200,b:209).withAlphaComponent(0.4).cgColor,UIColor(r:247,g:200,b:209).withAlphaComponent(0.1).cgColor] as! CFArray, locations: [0.0,1.0])
        context.drawLinearGradient(gradient1!, start: startpoint, end: endpoint, options: [])
        context.restoreGState()
        for i in  0...uprange
        {   let val=Int.random(in: 0...12)
            let scale=12/self.bounds.height-Constant.border
            let circle1=UIBezierPath(ovalIn: CGRect(x:Xpon(i+1)-4,y:Ypon(Int(plotPoints[i]))-4,width:8,height:8))
            UIColor(r:255,g:45,b:85).setStroke()
            UIColor.white.setFill()
            circle1.lineWidth=5
            circle1.fill()
            circle1.stroke()
            context.addPath(circle1.cgPath)
        }
    }
}

extension UIView{
    func getMonthName(from monthNumber: Int) -> String? {
        guard monthNumber >= 1 && monthNumber <= 12 else {
            return nil // Return nil for invalid month numbers
        }
        
        let dateFormatter = DateFormatter()
        let monthName = dateFormatter.monthSymbols[monthNumber - 1]
        let shortMonthName = String(monthName.prefix(3)) // Get the first 3 characters
            return shortMonthName
    }
   
}
