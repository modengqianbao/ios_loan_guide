//
//  LGQuestionQuestionTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

class LGQuestionContentTableViewCell: UITableViewCell {
    static let identifier = "LGQuestionContentTableViewCell"
    
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
            make.edges.equalTo(UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20))
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configCell(content: String) {
        contentLabel.text = content
    }
}
