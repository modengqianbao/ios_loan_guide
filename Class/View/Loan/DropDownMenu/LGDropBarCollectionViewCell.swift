//
//  LGDropBarCollectionViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 31/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGDropBarCollectionViewCell: UICollectionViewCell {
    static let identifier = "LGDropBarCollectionViewCell"
    
    private var titleLabel: UILabel!
    private var triangleImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        
        // 标签
        titleLabel = UILabel()
        titleLabel.textColor = kColorTitleText
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.centerX.equalTo(self!).offset(-4)
        }
        
        // 三角
        triangleImageView = UIImageView(image: UIImage(named: "triangle_grey"))
        addSubview(triangleImageView)
        triangleImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
        }
    }
    
    func configCell(title: String, highlighted: Bool) {
        titleLabel.text = title
        if highlighted {
            triangleImageView.image = UIImage(named: "triangle_blue")
            titleLabel.textColor = kColorMainTone
        } else {
            triangleImageView.image = UIImage(named: "triangle_grey")
            titleLabel.textColor = kColorTitleText
        }
    }
}
