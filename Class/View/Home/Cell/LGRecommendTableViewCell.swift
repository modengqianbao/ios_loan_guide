//
//  LGRecommendTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

protocol LGRecommendTableViewCellDelegate {
    func recommendTableViewCellDidSelectLeftBanner(cell: LGRecommendTableViewCell)
    func recommendTableViewCellDidSelectRightBanner(cell: LGRecommendTableViewCell)
}

class LGRecommendTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendTableViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorSeperatorBackground
        selectionStyle = .none
        
        let height = CGFloat(80)
        // 左边板块
        let leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFill
        leftImageView.layer.cornerRadius = 4
        leftImageView.layer.masksToBounds = true
        leftImageView.backgroundColor = UIColor.red
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!)
            make.left.equalTo(self!).offset(8)
            make.bottom.equalTo(self!).offset(-8)
            make.right.equalTo(self!.snp.centerX).offset(-4)
            make.height.equalTo(height)
        }
        
        // 右边板块
        let rightImageView = UIImageView()
        rightImageView.contentMode = .scaleAspectFill
        rightImageView.layer.cornerRadius = 4
        rightImageView.layer.masksToBounds = true
        rightImageView.backgroundColor = UIColor.red
        addSubview(rightImageView)
        rightImageView.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!)
            make.bottom.right.equalTo(self!).offset(-8)
            make.left.equalTo(self!.snp.centerX).offset(4)
            make.height.equalTo(height)
        }
    }
}
