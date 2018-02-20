//
//  LGReportHeadTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 17/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

protocol LGReportHeadTableViewCellDelegate: class {
    func headCellDidClickBack(_ headCell: LGReportHeadTableViewCell)
}

class LGReportHeadTableViewCell: UITableViewCell {
    static let identifier = "LGReportHeadTableViewCell"
    
    weak var delegate: LGReportHeadTableViewCellDelegate?
    
    private var creditView: LGCreditView!
    
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
        
        // 背景
        let backImageView = UIImageView(image: UIImage(named: "bg"))
        backImageView.clipsToBounds = true
        addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        // 标题视图
        let headView = UIView()
        headView.backgroundColor = UIColor.clear
        addSubview(headView)
        headView.snp.makeConstraints { [weak self] make in
            make.height.equalTo(44)
            make.left.right.equalTo(self!)
            make.top.equalTo(self!).offset(20)
        }
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back_white"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
        backButton.sizeToFit()
        headView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(headView)
            make.left.equalTo(headView).offset(12)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "信用报告"
        headView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(headView)
        }
        
        // 信用视图
        let width = CGFloat(170)
        creditView = LGCreditView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        addSubview(creditView)
        creditView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(headView.snp.bottom).offset(4)
            make.size.equalTo(CGSize(width: width, height: width))
        }
    }
    
    @objc private func backButtonOnClick() {
        delegate?.headCellDidClickBack(self)
    }
    
    func animate() {
        creditView.animate()
    }
}
