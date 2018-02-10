//
//  LGMineViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGMineViewController: LGViewController {
    private var phoneLabel: UILabel!
    private var vericationLabel: UILabel!
    
    private let model = LGMineModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupNotification()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupSubviews() {
        navigationItem.title = "我的"
        
        // 顶部视图
        let topView = UIImageView(image: UIImage(named: "bg_my"))
        topView.backgroundColor = UIColor.blue
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(topViewOnTouch))
        topView.isUserInteractionEnabled = true
        topView.addGestureRecognizer(tapGR)
        view.addSubview(topView)
        topView.snp.makeConstraints { [weak self] make in
            make.left.top.right.equalTo(self!.view)
        }
        
        // 头像
        let avatarRadius = CGFloat(30)
        let avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = avatarRadius
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: "avatar")
        topView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: avatarRadius * 2, height: avatarRadius * 2))
            make.centerY.equalTo(topView).offset(10)
            make.left.equalTo(topView).offset(12)
        }
        
        // 手机号 / “请点击登录”
        phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.white
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        phoneLabel.text = "请点击登录"
        phoneLabel.sizeToFit()
        topView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(12)
            make.top.equalTo(avatarImageView).offset(8)
        }
        
        // 认证标签
        vericationLabel = UILabel()
        vericationLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        vericationLabel.textAlignment = .center
        vericationLabel.textColor = UIColor.white
//        vericationLabel.backgroundColor = UIColor.red
//        vericationLabel.text = "未认证"
        topView.addSubview(vericationLabel)
        vericationLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 54, height: 20))
            make.left.equalTo(phoneLabel)
            make.top.equalTo(phoneLabel.snp.bottom).offset(4)
        }
        
        // 右箭头
        let arrowImageView = UIImageView(image: UIImage(named: "my_arrow_r"))
        topView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(topView).offset(10)
            make.right.equalTo(topView).offset(-12)
        }
        
        // 按钮视图
        let height = CGFloat(75)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth / 3,
                                 height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let buttonCollectionView = UICollectionView(frame: CGRect.zero,
                                                    collectionViewLayout: layout)
        buttonCollectionView.register(LGMineButtonCollectionViewCell.self, forCellWithReuseIdentifier: LGMineButtonCollectionViewCell.identifier)
        buttonCollectionView.backgroundColor = kColorBackground
        buttonCollectionView.bounces = false
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
        view.addSubview(buttonCollectionView)
        buttonCollectionView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!.view)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(height)
        }
        
        // 选项列表
        let mineTableView = UITableView(frame: CGRect.zero, style: .grouped)
        mineTableView.backgroundColor = kColorSeperatorBackground
        mineTableView.register(LGMineTableViewCell.self, forCellReuseIdentifier: LGMineTableViewCell.identifier)
        mineTableView.separatorStyle = .none
        mineTableView.delegate = self
        mineTableView.dataSource = self
        view.addSubview(mineTableView)
        mineTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(buttonCollectionView.snp.bottom)
        }
    }
    
    private func setupNotification() {
        // 接收登陆通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLoginNotification), name: kNotificationLogin.name, object: nil)
        // 接收登出通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLogoutNotification), name: kNotificationLogout.name, object: nil)
        
    }
    
    private func reloadData() {
        if LGUserModel.currentUser.isLogin {
            phoneLabel.text = LGUserModel.currentUser.phone
            
            vericationLabel.isHidden = false
            if LGUserModel.currentUser.isVerified {
                vericationLabel.backgroundColor = UIColor(red:0.15, green:0.80, blue:0.34, alpha:1.00)
                vericationLabel.text = "已认证"
            } else {
                vericationLabel.backgroundColor = UIColor(red:0.88, green:0.17, blue:0.26, alpha:1.00)
                vericationLabel.text = "未认证"
            }
        } else {
            phoneLabel.text = "请点击登录"
            
            vericationLabel.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func receiveLoginNotification() {
        reloadData()
    }
    
    @objc private func receiveLogoutNotification() {
        reloadData()
    }
    
    @objc private func topViewOnTouch() {
        if LGUserModel.currentUser.isLogin {
            
        } else {
            showLoginVC()
        }
    }
    
    private func showLoginVC() {
        let loginVC = LGLoginViewController()
        let nc = LGNavigationController(rootViewController: loginVC)
        present(nc, animated: true, completion: nil)
    }
}

//MARK:- UITableView delegate, datasource
extension LGMineViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGMineTableViewCell.identifier) as! LGMineTableViewCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.configCell(icon: UIImage(named: "list_problem"), title: "常见问题", hideSeparator: false)
            } else if indexPath.row == 1 {
                cell.configCell(icon: UIImage(named: "list_service"), title: "客服服务", hideSeparator: false)
            } else {
                cell.configCell(icon: UIImage(named: "list_account"), title: "微信公众号", hideSeparator: true)
            }
        } else {
            cell.configCell(icon: UIImage(named: "list_set"), title: "设置", hideSeparator: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LGUserModel.currentUser.isLogin {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    // 常见问题
                    let questionVC = LGQuestionViewController()
                    questionVC.model = model
                    questionVC.hidesBottomBarWhenPushed = true
                    show(questionVC, sender: nil)
                } else if indexPath.row == 1 {
                    // 客服
                    let qrcodeVC = LGQRCodeViewController(type: .service)
                    present(qrcodeVC, animated: true, completion: nil)
                } else {
                    // 公众号
                    let qrcodeVC = LGQRCodeViewController(type: .official)
                    present(qrcodeVC, animated: true, completion: nil)
                }
            } else {
                let settingVC = LGSettingViewController()
                settingVC.hidesBottomBarWhenPushed = true
                show(settingVC, sender: nil)
            }
        } else {
            showLoginVC()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- UICollectionView delegate, datasource
extension LGMineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LGMineButtonCollectionViewCell.identifier, for: indexPath) as! LGMineButtonCollectionViewCell
        if indexPath.row == 0 {
            cell.configCell(icon: UIImage(named: "credit"), title: "信用知多少")
        } else if indexPath.row == 1 {
            cell.configCell(icon: UIImage(named: "record"), title: "申请记录")
        } else {
            cell.configCell(icon: UIImage(named: "message"), title: "消息中心")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if LGUserModel.currentUser.isLogin {
            if indexPath.row == 0 {
                // 信用知多少
            } else if indexPath.row == 1 {
                // 申请记录
                let recordVC = LGRecordViewController()
                recordVC.hidesBottomBarWhenPushed = true
                recordVC.model = model
                show(recordVC, sender: nil)
            } else {
                // 消息中心
                let messageVC = LGMessageViewController()
                messageVC.hidesBottomBarWhenPushed = true
                messageVC.model = model
                show(messageVC, sender: nil)
            }
        } else {
            showLoginVC()
        }
    }
}
