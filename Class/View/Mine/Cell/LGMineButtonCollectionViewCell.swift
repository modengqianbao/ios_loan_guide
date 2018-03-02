//
//  LGMineButtonCollectionViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 27/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGMineButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "LGMineButtonCollectionViewCell"
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 图标
        let iconWidth = CGFloat(24)
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(14)
            make.size.equalTo(CGSize(width: iconWidth, height: iconWidth))
        }
        
        // 标题
        titleLabel = UILabel()
        titleLabel.textColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.00)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
        }
        
        // 分割线
        let lineView = UIView()
        lineView.backgroundColor = kColorBorder
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!)
            make.size.equalTo(CGSize(width: 1, height: 30))
            make.centerY.equalTo(self!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(icon: UIImage?, title: String) {
        iconImageView.image = icon
        titleLabel.text = title
    }
}
