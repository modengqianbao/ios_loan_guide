//
//  LGHomeViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 26/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import MBProgressHUD
//import RxWebViewController

class LGHomeViewController: LGViewController {
    
    private var homeTableView: UITableView!   
    
    private let model = LGHomeModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubviews()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadData() {
        homeTableView.mj_header.beginRefreshing()
    }
    
    private func setup() {
        navigationItem.title = "莫等钱包"
        
        view.backgroundColor = kColorBackground
    }
    
    private func setupSubviews() {
        let whiteView = UIView()
        whiteView.backgroundColor = kColorBackground
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view.snp.top)
            make.height.equalTo(100)
        }
        
        homeTableView = UITableView(frame: CGRect.zero,
                                    style: .grouped)
        homeTableView.separatorStyle = .none
        homeTableView.rowHeight = UITableViewAutomaticDimension
        homeTableView.estimatedRowHeight = 80
        homeTableView.backgroundColor = kColorSeperatorBackground
        homeTableView.register(LGRecommendTableViewCell.self, forCellReuseIdentifier: LGRecommendTableViewCell.identifier)
        homeTableView.register(LGCreditCheckTableViewCell.self, forCellReuseIdentifier: LGCreditCheckTableViewCell.identifier)
        homeTableView.register(LGHotProductTableViewCell.self, forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
        homeTableView.register(LGCreditCardTableViewCell.self, forCellReuseIdentifier: LGCreditCardTableViewCell.identifier)
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self!.model.getHomeData { error in
                self!.homeTableView.mj_header.endRefreshing()
                if error == nil {
                    self!.homeTableView.reloadData()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        })
        homeTableView.delegate = self
        homeTableView.dataSource = self
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { [weak self] make in
            make.top.left.right.bottom.equalTo(self!.view)
        }
    }
    
    private func showCreditCheckOrReportView() {
        MBProgressHUD.showAdded(to: view, animated: true)
        LGCreditService.sharedService.getHistoryReportID { [weak self] id, error in
            MBProgressHUD.hide(for: self!.view, animated: true)
            if error == nil {
                if id != nil {
                    // 有查询历史记录
                    let reportVC = LGReportViewController()
                    reportVC.queryID = id!
                    reportVC.hidesBottomBarWhenPushed = true
                    self!.show(reportVC, sender: nil)
                } else {
                    // 无查询历史记录
                    let creditVC = LGCreditCheckFlowViewController()
                    creditVC.hidesBottomBarWhenPushed = true
                    self!.show(creditVC, sender: nil)
                }
            } else {
                LGHud.show(in: self!.view, animated: true, text: error)
            }
        }
    }
    
    private func showLogin() {
        let loginVC = LGLoginViewController()
        let nc = LGNavigationController(rootViewController: loginVC)
        present(nc, animated: true, completion: nil)
    }
    
    private func showDetail(withLoanItem loanItem: LGLoanProductModel) {
        if LGUserModel.currentUser.isLogin {
            if loanItem.isRecommended {
                let detailVC = LGRecommendDetailViewController()
                detailVC.model = loanItem
                detailVC.hidesBottomBarWhenPushed = true
                show(detailVC, sender: nil)
            } else {
                let detailVC = LGNormalDetailViewController()
                detailVC.model = loanItem
                detailVC.hidesBottomBarWhenPushed = true
                show(detailVC, sender: nil)
            }
        } else {
            // 未登录弹出登录框
            let loginVC = LGLoginViewController()
            let nc = LGNavigationController(rootViewController: loginVC)
            present(nc, animated: true, completion: nil)
        }
    }
}

//MAKR:- UITableView delegate, datasource
extension LGHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 急速好贷
            if model.bannerArticleURLString == nil {
                return 1
            } else {
                return 2
            }
        } else if section == 1 {
            // 热门产品
            return model.loanProductArray.count
        } else {
            // 信用卡产品
            return model.creditProductArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "莫等钱包")
        } else if section == 1 {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "热门产品")
        } else {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "信用卡产品")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 急速好贷
            if indexPath.row == 0 {
                // banner
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTableViewCell.identifier) as! LGRecommendTableViewCell
                if model.bannerArray.count == 1 {
                    cell.configCell(leftImageURLString: kImageDomain.appending(model.bannerArray[0].imageURLString),
                                    rightImageURLString: nil)
                } else if model.bannerArray.count >= 2 {
                    cell.configCell(leftImageURLString: kImageDomain.appending(model.bannerArray[0].imageURLString),
                                    rightImageURLString: kImageDomain.appending(model.bannerArray[1].imageURLString))
                } else {
                    cell.configCell(leftImageURLString: nil, rightImageURLString: nil)
                }
                cell.delegate = self
                
                return cell
            } else {
                // 信用知多少
                let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckTableViewCell.identifier) as! LGCreditCheckTableViewCell
                if let imageURLString = model.bannerArticleImageURLString {
                    cell.configCell(imageURL: kImageDomain.appending(imageURLString))
                }
                
                return cell
            }
        } else if indexPath.section == 1 {
            // 热门产品
            let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
            let item = model.loanProductArray[indexPath.row]
            cell.configCell(iconURLString: kImageDomain.appending(item.logoString),
                            title: item.name,
                            adString: item.labelString,
                            moneyString: "\(item.loanMax)",
                            describeString: item.loanSpec)
            return cell
        } else {
            // 信用卡产品
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCardTableViewCell.identifier) as! LGCreditCardTableViewCell
            let item = model.creditProductArray[indexPath.row]
            cell.configCell(iconURLString: kImageDomain.appending(item.logoURL),
                            title: item.name,
                            content: item.introduce,
                            extra: item.label)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                    // 信用知多少
//                    showCreditCheckOrReportView()
                if let urlString = model.bannerArticleURLString {
                    let url = URL(string: urlString)
                    let webVC = LGWebViewController(url: url!)!
                    webVC.hidesBottomBarWhenPushed = true
                    show(webVC, sender: nil)
                }
            }
        } else if indexPath.section == 1 {
            let loanItem = model.loanProductArray[indexPath.row]
            showDetail(withLoanItem: loanItem)           
        } else {
            if LGUserModel.currentUser.isLogin {
                let creditItem = model.creditProductArray[indexPath.row]
                let url = URL(string: creditItem.urlString)
                let webVC = LGWebViewController(url: url)!
                webVC.navigationController?.navigationBar.tintColor = kColorTitleText
                webVC.hidesBottomBarWhenPushed = true
                show(webVC, sender: nil)
            } else {
                showLogin()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
}

extension LGHomeViewController: LGRecommendTableViewCellDelegate {
    func recommendTableViewCellDidSelectLeftBanner(cell: LGRecommendTableViewCell) {
        let bannerModel = model.bannerArray[0]
        let loanItem = LGLoanProductModel(bannerModel: bannerModel)
        showDetail(withLoanItem: loanItem)
        
        LGUserService.sharedService.recordBehavior(behavior: .clickBanner, complete: nil)
    }
    
    func recommendTableViewCellDidSelectRightBanner(cell: LGRecommendTableViewCell) {
        let bannerModel = model.bannerArray[1]
        let loanItem = LGLoanProductModel(bannerModel: bannerModel)
        showDetail(withLoanItem: loanItem)

        LGUserService.sharedService.recordBehavior(behavior: .clickBanner, complete: nil)
    }
}
