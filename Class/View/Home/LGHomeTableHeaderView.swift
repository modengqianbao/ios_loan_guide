//
//  LGTableHeaderView.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGHomeTableHeaderView: UIView {
    init(frame: CGRect, title: String?) {
        super.init(frame: frame)
        
        setup()
        setupSubviews(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorSeperatorBackground
    }
    
    private func setupSubviews(title: String?) {
        // 蓝色矩形
        let blueView = UIView()
        blueView.backgroundColor = kColorMainTone
        addSubview(blueView)
        blueView.snp.makeConstraints { [weak self] make in
            make.size.equalTo(CGSize(width: 5, height: 15))
            make.left.equalTo(self!.snp.left).offset(8)
            make.top.equalTo(self!.snp.top).offset(8)
            make.bottom.equalTo(self!.snp.bottom).offset(-8)
        }
        
        // 标签
        let label = UILabel()
        label.textColor = kColorTitleText
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = title
        label.sizeToFit()
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(blueView.snp.right).offset(8)
            make.centerY.equalTo(blueView)
        }
    }
}
