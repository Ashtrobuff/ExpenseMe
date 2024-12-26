import UIKit

class CircularGraphView: UIView {
    private var progress: CGFloat = 0
    private var total: CGFloat = 100

    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    // Method to set progress and total, then trigger a redraw
    func setProgress(_ progress: CGFloat, total: CGFloat) {
        self.progress = progress
        self.total = total
        self.setNeedsDisplay() // Triggers a redraw
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 15
        
        // Draw background circle
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        backgroundPath.lineWidth = 10
        UIColor(r:224,g:224,b:224).setStroke()
        backgroundPath.stroke()
        
        // Draw progress circle
        let startAngle: CGFloat = -CGFloat.pi / 2 // Start at the top
        let progressAngle = (progress / total) * CGFloat.pi * 2
        let endAngle = startAngle + progressAngle
        
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressPath.lineWidth = 13
        progressPath.lineJoinStyle = .bevel
        
        progressPath.lineCapStyle = .round
        UIColor(red: 1, green: 0.18, blue: 0.33, alpha: 1).setStroke()
        progressPath.stroke()
    }
}
