//
//  GraphView.swift
//  ExpenseMe
//
//  Created by Ashish on 17/12/24.
//
import Foundation
import UIKit
import CoreGraphics
private enum Constants {
  static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
  static let margin: CGFloat = 20.0
  static let topBorder: CGFloat = 60
  static let bottomBorder: CGFloat = 50
  static let colorAlpha: CGFloat = 0.3
  static let circleDiameter: CGFloat = 5.0
}
class GraphView:UIView
{   var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    var letto=[5,6,6,7,8,9]
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: .allCorners,
            cornerRadii: Constants.cornerRadiusSize
          )
          path.addClip()
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
          // Calculate the gap between points
          let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
          return CGFloat(column) * spacing + margin + 2
        }
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else {
          return
        }
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
          let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
          return graphHeight + topBorder - yPoint // Flip the graph
        }
        guard let context=UIGraphicsGetCurrentContext() else { return }
        let colors=[UIColor(r:250,g:233,b:110).cgColor,UIColor(r:252,g:79,b:8).cgColor]
        let colorLocations:[CGFloat]=[0.0,1.0]
        guard let gradient=CGGradient(colorsSpace:CGColorSpaceCreateDeviceRGB(),colors:colors as CFArray, locations:colorLocations) else { return }
        let startPoint=CGPoint.zero
        let endPoint=CGPoint(x:0,y:bounds.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
            
        // Set up the points line
        let graphPath = UIBezierPath()

        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
            
        // Add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints.count {
          let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          graphPath.addLine(to: nextPoint)
        }

        graphPath.stroke()
        context.saveGState()
        guard let clippingPath=graphPath.copy() as? UIBezierPath
        else{
            return
        }
        clippingPath.addLine(to: CGPoint(
          x: columnXPoint(graphPoints.count - 1),
          y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
            
        // 4 - Add the clipping path to the context
        clippingPath.addClip()
            

        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
                
        context.drawLinearGradient(
          gradient,
          start: graphStartPoint,
          end: graphEndPoint,
          options: [] )
        context.restoreGState()
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        let linePath = UIBezierPath()

        // Top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))

        // Center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))

        // Bottom line
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
            
        linePath.lineWidth = 1.0
        linePath.stroke()
        for i in 0..<graphPoints.count {
          var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
          point.x -= Constants.circleDiameter / 2
          point.y -= Constants.circleDiameter / 2
              
          let circle = UIBezierPath(
            ovalIn: CGRect(
              origin: point,
              size: CGSize(
                width: Constants.circleDiameter,
                height: Constants.circleDiameter)
            )
          )
          circle.fill()
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: a
        )
    }
}
 
