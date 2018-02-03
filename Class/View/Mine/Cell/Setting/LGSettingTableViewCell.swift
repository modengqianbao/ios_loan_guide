//
//  LGSettingTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGSettingTableViewCell: UITableViewCell {
    static let identifier = "LGSettingTableViewCell"
    
    private var titleLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = kColorBackground
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = kColorTitleText
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 80))
        }
        
        let arrowImageView = UIImageView(image: UIImage(named: "detail_arrow_r"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { [weak self] make in
            make.right.equalTo(self!).offset(-8)
            make.centerY.equalTo(self!)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configCell(title: String?) {
        titleLabel.text = title
    }
}
