//
//  LGRecommendDetailNaviTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 29/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit

protocol LGRecommendDetailHeadTableViewCellDelegate: class {
    func headCellDidClickBack(_ headCell: LGRecommendDetailHeadTableViewCell)
    func headCellDidClickShare(_ headCell: LGRecommendDetailHeadTableViewCell)
    func headCellDidClickLoanMoney(_ headCell: LGRecommendDetailHeadTableViewCell)
    func headCellDidClickLoanTime(_ headCell: LGRecommendDetailHeadTableViewCell)
    func headCellDidClickLoanUsage(_ headCell: LGRecommendDetailHeadTableViewCell)    
}

class LGRecommendDetailHeadTableViewCell: UITableViewCell {
    static let identifier = "LGRecommendDetailHeadTableViewCell"
    
    weak var delegate: LGRecommendDetailHeadTableViewCellDelegate?
    
    /// 贷款名
    private var titleLabel: UILabel!
    /// 当前选择额度
    private var limitButton: UIButton!
    /// 额度标签
    private var limitLabel: UILabel!
    /// 当前选择分期
    private var stageButton: UIButton!
    /// 分期标签
    private var stageLabel: UILabel!
    /// 用途
    private var usageLabel: UILabel!
    /// 描述标签
    private var descLabel: UILabel!
    
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
        let backgroundImageView = UIImageView(image: UIImage(named: "bg_detail"))
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { [weak self] make in
            make.left.right.top.equalTo(self!)
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
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        naviView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(naviView).offset(4)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(naviView)
        }
        
        // 标题
        titleLabel = UILabel()
//        titleLabel.text = "马上金融"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        naviView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(naviView)
            make.centerY.equalTo(naviView)
        }
        
        // 分享
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "nav_share"), for: .normal)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        naviView.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(naviView)
            make.right.equalTo(naviView).offset(-12)
        }
        
        // 白色框
        let whiteView = UIView()
        whiteView.backgroundColor = kColorBackground
        whiteView.layer.cornerRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 1, height: 1)
        whiteView.layer.shadowOpacity = 0.11
        addSubview(whiteView)
        whiteView.snp.makeConstraints { [weak self] make in
            make.left.equalTo(self!).offset(17)
            make.right.equalTo(self!).offset(-17)
            make.top.equalTo(naviView.snp.bottom).offset(12)
            make.height.equalTo(145)
        }
        
        // 额度
        limitButton = UIButton(type: .custom)
        limitButton.setTitleColor(kColorMainTone, for: .normal)
//        limitButton.setTitle("3000元", for: .normal)
        limitButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        whiteView.addSubview(limitButton)
        limitButton.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView).multipliedBy(0.5).offset(-4)
            make.top.equalTo(whiteView).offset(18)
        }
        
        let leftTriangle = UIImageView(image: UIImage(named: "triangle_blue"))
        whiteView.addSubview(leftTriangle)
        leftTriangle.snp.makeConstraints { make in
            make.centerY.equalTo(limitButton)
            make.left.equalTo(limitButton.snp.right).offset(2)
        }
        
        limitLabel = UILabel()
        limitLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        limitLabel.textColor = kColorAssistText
//        limitLabel.text = "额度1000~8000"
        whiteView.addSubview(limitLabel)
        limitLabel.snp.makeConstraints { make in
            make.top.equalTo(limitButton.snp.bottom)
            make.centerX.equalTo(whiteView).multipliedBy(0.5)
        }
        
        // 分割线
        let middleLine = UIView()
        middleLine.backgroundColor = kColorBorder
        whiteView.addSubview(middleLine)
        middleLine.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView)
            make.size.equalTo(CGSize(width: 1, height: 26))
            make.top.equalTo(whiteView).offset(32)
        }
        
        // 分期
        stageButton = UIButton(type: .custom)
        stageButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        stageButton.setTitleColor(kColorMainTone, for: .normal)
//        stageButton.setTitle("180日", for: .normal)
        whiteView.addSubview(stageButton)
        stageButton.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView).multipliedBy(1.5).offset(-4)
            make.top.equalTo(whiteView).offset(18)
        }
        
        let rightTriangle = UIImageView(image: UIImage(named: "triangle_blue"))
        whiteView.addSubview(rightTriangle)
        rightTriangle.snp.makeConstraints { make in
            make.centerY.equalTo(stageButton)
            make.left.equalTo(stageButton.snp.right).offset(2)
        }
        
        stageLabel = UILabel()
        stageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        stageLabel.textColor = kColorAssistText
//        stageLabel.text = "分期90-360期"
        whiteView.addSubview(stageLabel)
        stageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView).multipliedBy(1.5)
            make.top.equalTo(stageButton.snp.bottom)
        }
        
        // 贷款用途框
        let usageView = UIView()
        usageView.backgroundColor = kColorBackground
        usageView.layer.cornerRadius = 3
        usageView.layer.borderColor = kColorBorder.cgColor
        usageView.layer.borderWidth = 1
        whiteView.addSubview(usageView)
        usageView.snp.makeConstraints { make in
            make.left.equalTo(whiteView).offset(22)
            make.right.equalTo(whiteView).offset(-22)
            make.height.equalTo(34)
            make.top.equalTo(middleLine.snp.bottom).offset(32)
        }
        
        let usageTitleLabel = UILabel()
        usageTitleLabel.textColor = kColorAssistText
        usageTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        usageTitleLabel.text = "贷款用途"
        usageView.addSubview(usageTitleLabel)
        usageTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(usageView)
            make.left.equalTo(usageView).offset(8)
        }
        
        let usageLineView = UIView()
        usageLineView.backgroundColor = kColorBorder
        usageView.addSubview(usageLineView)
        usageLineView.snp.makeConstraints { make in
            make.left.equalTo(usageTitleLabel.snp.right).offset(8)
            make.centerY.equalTo(usageView)
            make.size.equalTo(CGSize(width: 1, height: 20))
        }
        
        usageLabel = UILabel()
        usageLabel.textColor = kColorTitleText
        usageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        usageLabel.text = "2222"
        usageView.addSubview(usageLabel)
        usageLabel.snp.makeConstraints { make in
            make.left.equalTo(usageLineView).offset(8)
            make.centerY.equalTo(usageView)
        }
        
        let usageTriangleView = UIImageView(image: UIImage(named: "triangle_grey"))
        usageView.addSubview(usageTriangleView)
        usageTriangleView.snp.makeConstraints { make in
            make.centerY.equalTo(usageView)
            make.right.equalTo(usageView).offset(-8)
        }
        
        
        // 说明文字
//        let descString = " 平均1小时放款   日利率0.02%"
//        let attributedDescString = NSMutableAttributedString(string: descString)
//        let checkImage = UIImage(named: "tick_linear")
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = checkImage
//        imageAttachment.bounds = CGRect(x: 0,
//                                        y: -1,
//                                        width: checkImage!.size.width,
//                                        height: checkImage!.size.height)
//        attributedDescString.addAttribute(NSAttributedStringKey.font,
//                                          value: UIFont.systemFont(ofSize: 14, weight: .regular),
//                                          range: NSRange.init(location: 0, length: descString.count))
//        attributedDescString.addAttribute(NSAttributedStringKey.foregroundColor,
//                                          value: kColorTitleText,
//                                          range: NSRange.init(location: 0, length: descString.count))
//        attributedDescString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
//        attributedDescString.insert(NSAttributedString(attachment: imageAttachment), at: 11)
        
        descLabel = UILabel()
//        descLabel.attributedText = attributedDescString
        addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteView)
            make.top.equalTo(whiteView.snp.bottom).offset(8)
        }
        
        // 分割线
        let separatorLine = UIView()
        separatorLine.backgroundColor = kColorBorder
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!)
            make.height.equalTo(1)
            make.top.equalTo(descLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self!)
        }
    }
    
    private func describeText(_ timeString: String, rateString: String) -> NSMutableAttributedString {
        let checkImage = UIImage(named: "tick_linear")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = checkImage
        imageAttachment.bounds = CGRect(x: 0,
                                        y: -1,
                                        width: checkImage!.size.width,
                                        height: checkImage!.size.height)
        
        let textAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                              NSAttributedStringKey.foregroundColor: kColorTitleText]
        let attributedTimeString = NSMutableAttributedString(string: timeString, attributes: textAttributes)
        attributedTimeString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        let attributedRateString = NSMutableAttributedString(string: rateString, attributes: textAttributes)
        attributedRateString.insert(NSAttributedString(attachment: imageAttachment), at: 0)
        attributedTimeString.append(attributedRateString)
        
        return attributedTimeString
    }
    
    @objc private func back() {
        delegate?.headCellDidClickBack(self)
    }
    
    @objc private func share() {
        
    }
    
    /// 贷款名，当前选择贷款，贷款额度，贷款时间，分期范围，贷款用途，放款时间，日利率
    func configCell(title: String, currentMoney: Int, limitString: String?, currentStage: String, stageRange: String?, usage: String?, timeString: String, rateString: String) {
        titleLabel.text = title
        limitButton.setTitle("\(currentMoney)元", for: .normal)
        limitLabel.text = limitString
        stageButton.setTitle(currentStage, for: .normal)
        stageLabel.text = stageRange
        usageLabel.text = usage
        descLabel.attributedText = describeText(timeString, rateString: rateString)
    }
}
