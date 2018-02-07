//
//  LGRecommendTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import Kingfisher

protocol LGRecommendTableViewCellDelegate: class {
    func recommendTableViewCellDidSelectLeftBanner(cell: LGRecommendTableViewCell)
    func recommendTableViewCellDidSelectRightBanner(cell: LGRecommendTableViewCell)
}

class LGRecommendTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendTableViewCell"
    
    weak var delegate: LGRecommendTableViewCellDelegate?
    
    private var leftImageView: UIImageView!
    private var rightImageView: UIImageView!

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
        
        let height = CGFloat(90)
        // 左边板块
        leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFill
        leftImageView.layer.cornerRadius = 4
        leftImageView.isUserInteractionEnabled = true
        leftImageView.layer.masksToBounds = true
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!)
            make.left.equalTo(self!).offset(8)
            make.bottom.equalTo(self!).offset(-8)
            make.right.equalTo(self!.snp.centerX).offset(-4)
            make.height.equalTo(height)
        }
        
        // 右边板块
        rightImageView = UIImageView()
        rightImageView.contentMode = .scaleAspectFill
        rightImageView.layer.cornerRadius = 4
        rightImageView.layer.masksToBounds = true
        rightImageView.isUserInteractionEnabled = true
        addSubview(rightImageView)
        rightImageView.snp.makeConstraints { [weak self] make in
            make.top.equalTo(self!)
            make.bottom.right.equalTo(self!).offset(-8)
            make.left.equalTo(self!.snp.centerX).offset(4)
            make.height.equalTo(height)
        }
        
        let leftTapGR = UITapGestureRecognizer(target: self, action: #selector(leftImageViewOnTap))
        let rightTapGR = UITapGestureRecognizer(target: self, action: #selector(rightImageViewOnTap))
        leftImageView.addGestureRecognizer(leftTapGR)
        rightImageView.addGestureRecognizer(rightTapGR)
    }
    
    func configCell(leftImageURLString: String?, rightImageURLString: String?) {
        if leftImageURLString != nil {
            let url = URL(string: leftImageURLString!)
            leftImageView.kf.setImage(with: url)
        }
        
        if rightImageURLString != nil {
            let url = URL(string: rightImageURLString!)
            rightImageView.kf.setImage(with: url)
        }
    }
    
    @objc private func leftImageViewOnTap(imageView: UIImageView) {
        delegate?.recommendTableViewCellDidSelectLeftBanner(cell: self)
    }
    
    @objc private func rightImageViewOnTap() {
        delegate?.recommendTableViewCellDidSelectRightBanner(cell: self)
    }
}
