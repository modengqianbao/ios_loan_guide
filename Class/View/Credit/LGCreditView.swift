//
//  LGCreditView.swift
//  LoanGuide
//
//  Created by 喂草。 on 17/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditView: UIView {
    // 传入
    /// 测评时间
    var dateString: String? {
        didSet {
            if dateString != nil {
                dateLabel.text = "测评时间\(dateString!)"
            }
        }
    }
    /// 信用分数
    var mark: Int! = 0
    /// 信用等级
    var level: String? {
        didSet {
            levelLabel.text = level
        }
    }
    
    private var markLabel: UILabel!
    private var levelLabel: UILabel!
    private var dateLabel: UILabel!
    private var dotView: UIView!
    
    private let emptyColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    private var path: UIBezierPath!
    private var currentMark: Int!
    private var timer: Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        layer.masksToBounds = false
        
        // 标数
        let numbersImageView = UIImageView(image: UIImage(named: "numbers"))
        numbersImageView.contentMode = .scaleAspectFill
        addSubview(numbersImageView)
        let inRadius = bounds.size.width / 2 - 8
        numbersImageView.snp.makeConstraints { [weak self] make in
            make.center.equalTo(self!)
            make.size.equalTo(CGSize(width: inRadius * 1.9, height: inRadius * 1.9))
        }
        
        // 分数
        markLabel = UILabel()
        markLabel.font = UIFont.systemFont(ofSize: 50, weight: .regular)
        markLabel.textColor = UIColor.white
        markLabel.textAlignment = .center
        markLabel.text = "0"
        addSubview(markLabel)
        markLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.centerY.equalTo(self!).offset(-12)
        }
        
        // 信用状态
        levelLabel = UILabel()
        levelLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        levelLabel.textColor = emptyColor
        levelLabel.textAlignment = .center
        levelLabel.text = "极好"
        let todotext = 1
        addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.centerX.equalTo(markLabel)
            make.bottom.equalTo(markLabel.snp.top)
        }
        
        // “综合信用分”
        let hintLabel = UILabel()
        hintLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        hintLabel.textColor = emptyColor
        hintLabel.textAlignment = .center
        hintLabel.text = "综合信用分"
        addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalTo(markLabel)
            make.top.equalTo(markLabel.snp.bottom).offset(3)
        }
        
        // 测评时间
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = emptyColor
        dateLabel.textAlignment = .center
        dateLabel.text = "测评时间2018年02月17日"
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { [weak self] make in
            make.bottom.centerX.equalTo(self!)
        }
        
        // 点
        let dotRadius = CGFloat(3)
        dotView = UIView(frame: CGRect(x: 0, y: 0, width: dotRadius * 2, height: dotRadius * 2))
        dotView.backgroundColor = UIColor.white
        dotView.layer.cornerRadius = dotRadius
        dotView.layer.shadowColor = UIColor.white.cgColor
        dotView.layer.shadowRadius = 1
        dotView.layer.shadowOpacity = 1
        dotView.layer.shadowOffset = CGSize.zero
        addSubview(dotView)
    }
    
    override func draw(_ rect: CGRect) {
        emptyColor.set()
        
        let rectCenter = CGPoint(x: rect.minX + rect.size.width / 2, y: rect.minY + rect.size.height / 2)
        let startAngle = CGFloat.pi * 0.75
        let endAngle = CGFloat.pi * 0.25
        
        // 画外圈
        let outRadius = rect.size.width / 2 - 1
        let outCircle = UIBezierPath(arcCenter: rectCenter,
                                     radius: outRadius,
                                     startAngle: startAngle,
                                     endAngle: endAngle,
                                     clockwise: true)
        outCircle.lineWidth = 1
        outCircle.lineCapStyle = .round
        outCircle.stroke()
        
        // 画内圈
        let inRadius = rect.size.width / 2 - 8
        let inCircle = UIBezierPath(arcCenter: rectCenter,
                                    radius: inRadius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
        inCircle.lineWidth = 4
        inCircle.lineCapStyle = .round
        inCircle.stroke()
    }
    
    private func makeNumberLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        
        return label
    }
    
    func animate() {
        let duration = 2.0
        
        // 计算角度
        let startAngle = CGFloat.pi * 0.75
        let offsetAngle = CGFloat(mark - 50) / CGFloat(50) * CGFloat.pi * CGFloat(1.4)
        let endAngle = startAngle + offsetAngle + CGFloat.pi * 0.05
        
        // 画线
        UIColor.white.set()
        path = UIBezierPath()
        let arcCenter = CGPoint(x: bounds.size.width / 2,
                                y: bounds.size.height / 2)
        path.addArc(withCenter: arcCenter,
                    radius: bounds.size.width / 2 - 1,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.delegate = self

        let shapeLayer = CAShapeLayer(layer: layer)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = kCALineCapRound
        layer.addSublayer(shapeLayer)
        shapeLayer.path = path.cgPath

        // 点运动
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        pathAnimation.path = path.cgPath
        pathAnimation.duration = duration
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        // 动起来
        dotView.layer.add(pathAnimation, forKey: nil)
        shapeLayer.add(animation, forKey: nil)
        
        // 数字
        if let count = mark {
            let second = CGFloat(duration) / CGFloat(count)
            currentMark = 0
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(second), target: self, selector: #selector(countMark), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func countMark() {
        markLabel.text = "\(currentMark!)"
        if currentMark < mark! {
            currentMark = currentMark + 1
        } else {
            timer.invalidate()
        }
    }
}

extension LGCreditView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            let offsetAngle = CGFloat(mark - 50) / CGFloat(50) * CGFloat.pi * CGFloat(1.4)
            let endAngle = CGFloat.pi * 0.8 + offsetAngle
            let arcCenter = CGPoint(x: bounds.size.width / 2,
                                    y: bounds.size.height / 2)
            let radius = bounds.size.width / 2 - 1
            let x = arcCenter.x + radius * cos(endAngle)
            let y = arcCenter.y + radius * sin(endAngle)
            
            dotView.center = CGPoint(x: x, y: y)
        }
    }
}
