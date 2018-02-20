//
//  LGReportContentTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 18/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGReportContentTableViewCell: UITableViewCell {
    static let identifier = "LGReportContentTableViewCell"
    
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
        contentLabel.numberOfLines = 0
        contentLabel.textColor = kColorAssistText
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20))
        }
    }
    
    func configCell(content: String?) {
        contentLabel.text = content
    }
}
