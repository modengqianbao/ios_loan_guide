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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        
        // “请点击登录”
        let loginLabel = UILabel()
        loginLabel.textColor = UIColor.white
        loginLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        loginLabel.text = "请点击登录"
        loginLabel.sizeToFit()
        topView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(12)
            make.top.equalTo(avatarImageView).offset(8)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func topViewOnTouch() {
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
        if indexPath.section == 0 {
            
        } else {
            let settingVC = LGSettingViewController()
            settingVC.hidesBottomBarWhenPushed = true
            show(settingVC, sender: nil)
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
}
