//
//  LGProductDetailFlowViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGProductDetailFlowTableViewCell: UITableViewCell {
    static let identifier = "LGProductDetailFlowTableViewCell"
    
    private var numberLabel: UILabel!
    private var contentLabel: UILabel!
    private var upLineView: UIView!
    private var downLineView: UIView!
    
    enum FlowCellType {
        case top
        case bottom
        case middle
        case only
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorBackground
        selectionStyle = .none
        
        // 数标
        let radius = CGFloat(8)
        numberLabel = UILabel()
        numberLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        numberLabel.textColor = UIColor.white
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = kColorMainTone
        numberLabel.layer.cornerRadius = radius
        numberLabel.layer.masksToBounds = true
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(self!)
            make.left.equalTo(self!).offset(12)
            make.size.equalTo(CGSize(width: radius * 2, height: radius * 2))
        }
        
        upLineView = UIView()
        upLineView.backgroundColor = kColorMainTone
        addSubview(upLineView)
        upLineView.snp.makeConstraints { [weak self] make in
            make.size.equalTo(CGSize(width: 1, height: 16))
            make.left.equalTo(self!).offset(20)
            make.top.equalTo(self!)
        }
        
        downLineView = UIView()
        downLineView.backgroundColor = kColorMainTone
        addSubview(downLineView)
        downLineView.snp.makeConstraints { [weak self] make in
            make.size.equalTo(CGSize(width: 1, height: 16))
            make.left.equalTo(self!).offset(20)
            make.bottom.equalTo(self!)
            make.top.equalTo(upLineView.snp.bottom)
        }
        
        // 标签
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = kColorTitleText
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(numberLabel.snp.right).offset(12)
            make.centerY.equalTo(numberLabel)
        }
        
        bringSubview(toFront: numberLabel)
    }
    
    func configCell(number: Int, type: FlowCellType, content: String?) {
        numberLabel.text = "\(number)"
        contentLabel.text = content
        switch type {
        case .top:
            upLineView.isHidden = true
            downLineView.isHidden = false
        case .bottom:
            upLineView.isHidden = false
            downLineView.isHidden = true
        case .middle:
            upLineView.isHidden = false
            downLineView.isHidden = false
        case .only:
            upLineView.isHidden = true
            downLineView.isHidden = true
        }
    }
}
