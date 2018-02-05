//
//  LGNormalDetailContentTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailContentTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailContentTableViewCell"
    
    private var contentLabel: UILabel!

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
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = kColorAssistText
        contentLabel.numberOfLines = 0
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20))
        }
    }
    
    func configCell(content: String?) {
        if content != nil {
            contentLabel.text = content!.replacingOccurrences(of: "<br>", with: "\n")
        }
    }
}
