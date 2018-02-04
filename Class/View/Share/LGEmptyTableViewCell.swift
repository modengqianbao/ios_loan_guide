//
//  LGEmptyTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGEmptyTableViewCell: UITableViewCell {
    static let identifier = "LGEmptyTableViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        let emptyImageView = UIImageView(image: UIImage(named: "error_product"))
        addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!).offset(50)
            make.bottom.equalTo(self!).offset(-50)
        }
    }
}
