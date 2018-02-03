//
//  LGQuestionContentTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGQuestionQuestionTableViewCell: UITableViewCell {
    static let identifier = "LGQuestionQuestionTableViewCell"
    
    private var questionLabel: UILabel!
    private var arrowImageView: UIImageView!

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
        
        // 问题标签
        questionLabel = UILabel()
        questionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        questionLabel.textColor = kColorAssistText
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 30))
        }
        
        // 箭头
        arrowImageView = UIImageView(image: UIImage(named: "detail_arrow_r"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(questionLabel)
            make.right.equalTo(self!).offset(-10)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kColorSeperatorBackground
        addSubview(lineView)
        lineView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(1)
        }
    }
    
    func configSelect(selected: Bool) {
        if selected {
            arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        } else {
            arrowImageView.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    func configCell(question: String) {
        questionLabel.text = question
    }
}
