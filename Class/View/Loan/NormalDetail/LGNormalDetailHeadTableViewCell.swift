//
//  LGNormailDetailHeadTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import Kingfisher

protocol LGNormalDetailHeaderTableViewCellDelegate: class {
    func headCellDidSelectBack(_ headerCell: LGNormalDetailHeadTableViewCell)
}

class LGNormalDetailHeadTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailHeadTableViewCell"
    
    weak var delegate: LGNormalDetailHeaderTableViewCellDelegate?
    
    private var iconImageView: UIImageView!
    private var titleLabel: UILabel!
    
    /// 贷款额度
    private var limitLabel: UILabel!
    /// 利率范围
    private var rateRangeLabel: UILabel!
    /// 还款方式
    private var methodLabel: UILabel!
    /// 期限范围
    private var timeRangeLabel: UILabel!
    
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
        
        // 背景图
        let backgoundImageView = UIImageView(image: UIImage(named: "bg_detail2"))
        addSubview(backgoundImageView)
        backgoundImageView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!)
        }
        
        // 适配X
        let upView = UIView()
        upView.backgroundColor = UIColor(red:0.33, green:0.55, blue:0.92, alpha:1.00)
        addSubview(upView)
        upView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!)
            make.bottom.equalTo(self!.snp.top)
            make.height.equalTo(40)
        }
        
        // 导航块
        let naviView = UIView()
        naviView.backgroundColor = UIColor.clear
        addSubview(naviView)
        naviView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!)
            make.height.equalTo(44)
            make.top.equalTo(self!).offset(20)
        }
        
        // 返回
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "nav_back_white"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonOnClick), for: .touchUpInside)
        naviView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(naviView).offset(4)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(naviView)
        }
        
        // 分享
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "nav_share"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonOnClick), for: .touchUpInside)
        naviView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(naviView)
            make.right.equalTo(naviView).offset(-12)
        }
        
        // 标题
        let iconRadius = CGFloat(30)
        iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = iconRadius
        iconImageView.layer.masksToBounds = true
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { [weak self] make in
            make.centerX.equalTo(self!)
            make.size.equalTo(CGSize(width: iconRadius * 2,
                                     height: iconRadius * 2))
            make.top.equalTo(self!).offset(32)
        }
        
        titleLabel = UILabel()
        titleLabel.text = "拍拍贷"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
        }
        
        // 详情
        let font = UIFont.systemFont(ofSize: 13, weight: .regular)
        let color = UIColor.white
        limitLabel = UILabel()
        limitLabel.adjustsFontSizeToFitWidth = true
        limitLabel.textColor = color
        limitLabel.font = font
        limitLabel.text = "贷款额度"
//        limitLabel.minimumScaleFactor = 0.5
        addSubview(limitLabel)
        limitLabel.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalTo(self!.snp.centerX).offset(-4)
        }
        
        rateRangeLabel = UILabel()
        rateRangeLabel.font = font
        rateRangeLabel.textColor = color
        rateRangeLabel.adjustsFontSizeToFitWidth = true
//        rateRangeLabel.minimumScaleFactor = 0.5
        rateRangeLabel.text = "利率范围"
        addSubview(rateRangeLabel)
        rateRangeLabel.snp.makeConstraints { [weak self] make in
            make.centerY.equalTo(limitLabel)
            make.left.equalTo(self!.snp.centerX).offset(8)
            make.right.equalTo(self!).offset(-4)
        }
        
        methodLabel = UILabel()
        methodLabel.font = font
        methodLabel.textColor = color
        methodLabel.text = "还款方式"
        addSubview(methodLabel)
        methodLabel.snp.makeConstraints { make in
            make.left.equalTo(limitLabel)
            make.top.equalTo(limitLabel.snp.bottom).offset(12)
        }
        
        timeRangeLabel = UILabel()
        timeRangeLabel.font = font
        timeRangeLabel.textColor = color
        timeRangeLabel.text = "期限范围"
        addSubview(timeRangeLabel)
        timeRangeLabel.snp.makeConstraints { make in
            make.left.equalTo(rateRangeLabel)
            make.top.equalTo(rateRangeLabel.snp.bottom).offset(12)
        }
    }
    
    @objc private func backButtonOnClick() {
        delegate?.headCellDidSelectBack(self)
    }
    
    @objc private func shareButtonOnClick() {
        
    }
    
    /// 名称，图片URL，贷款额度，利率范围，还款方式，期限范围
    func configCell(name: String, logoURLString: String, loanCount: String, rateRange:String, returnType: String, returnRange: String) {
        let url = URL(string: logoURLString)
        iconImageView.kf.setImage(with: url)
        titleLabel.text = name
        limitLabel.text = "贷款额度:".appending(loanCount)
        rateRangeLabel.text = "利率范围:".appending(rateRange)
        methodLabel.text = "还款方式:".appending(returnType)
        timeRangeLabel.text = "期限范围".appending(returnRange)
    }
}
