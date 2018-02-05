//
//  LGNormalDetailFlowCollectionViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 05/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailFlowCollectionViewCell: UICollectionViewCell {
    static let identifier = "LGNormalDetailFlowCollectionViewCell"
    
    private var numberLabel:UILabel!
    private var titleLabel: UILabel!
    private var rightArrowImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        
        rightArrowImageView = UIImageView(image: UIImage(named: "detail_arrow_r"))
        rightArrowImageView.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
        addSubview(rightArrowImageView)
        rightArrowImageView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.right.equalTo(self!).offset(-2)
        }
        
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.layer.cornerRadius = 3
        backgroundImageView.layer.masksToBounds = true
        setupGradient(imageView: backgroundImageView)
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { [weak self] make in
            make.top.bottom.left.equalTo(self!)
            make.right.equalTo(rightArrowImageView.snp.left).offset(-2)
        }
        
        numberLabel = UILabel()
        numberLabel.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        numberLabel.textColor = UIColor(red:0.19, green:0.42, blue:0.73, alpha:1.00)
        backgroundImageView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImageView)
            make.left.equalTo(backgroundImageView).offset(8)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        backgroundImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(4)
            make.right.equalTo(backgroundImageView).offset(-4)
            make.centerY.equalTo(backgroundImageView)
        }
    }
    
    private func setupGradient(imageView: UIImageView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        gradientLayer.colors = [UIColor(red:0.38, green:0.68, blue:0.90, alpha:1.00).cgColor,
                                UIColor(red:0.34, green:0.59, blue:0.94, alpha:1.00).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView.image = image
    }
    
    func configCell(number: Int, title: String, showArrow: Bool) {
        numberLabel.text = "\(number)"
        titleLabel.text = title
        rightArrowImageView.isHidden = !showArrow
    }
}
