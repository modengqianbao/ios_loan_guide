//
//  LGCreditCheckTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 27/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LGCreditCheckTableViewCell: UITableViewCell {
    static let identifier = "LGCreditCheckTableViewCell"
    
    private var backgroundImageView: UIImageView!
    
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
        
        // 背景图
        //        let backgroundImageView = UIImageView(image: UIImage(named: "banner_m"))
        // 换了图
        backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { [weak self] make in
            make.top.left.right.bottom.equalTo(self!)
            make.height.equalTo(kScreenWidth / 4.4)
        }
    }
    
    func configCell(imageURL: String) {
        let url = URL(string: imageURL)
        backgroundImageView.kf.setImage(with: url)
    }
}
