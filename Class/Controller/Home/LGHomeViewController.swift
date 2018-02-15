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
import RxWebViewController

class LGHomeViewController: LGViewController {
    
    private var homeTableView: UITableView!   
    
    private let model = LGHomeModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubviews()
        loadData()
        test()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func test() {
        let tett = 1

        let recVC = LGCreditCheckPayViewController()
        recVC.hidesBottomBarWhenPushed = true
        show(recVC, sender: nil)
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
            make.height.equalTo(64)
        }
        
        homeTableView = UITableView(frame: CGRect.zero,
                                    style: .grouped)
        homeTableView.separatorStyle = .none
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
}

//MAKR:- UITableView delegate, datasource
extension LGHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 急速好贷
            return 2
        } else if section == 1{
            // 热门产品
            return model.loanProductArray.count
        } else {
            // 信用卡产品
            return model.creditProductArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return LGHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), title: "极速好贷")
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
                let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckTableViewCell.identifier)!
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
                let creditVC = LGCreditCheckFlowViewController()
                creditVC.hidesBottomBarWhenPushed = true
                show(creditVC, sender: nil)
            }
        } else if indexPath.section == 1 {
            let loanItem = model.loanProductArray[indexPath.row]
            if loanItem.isRecommended {
                if LGUserModel.currentUser.isLogin {
                    let detailVC = LGRecommendDetailViewController()
                    detailVC.model = loanItem
                    detailVC.hidesBottomBarWhenPushed = true
                    show(detailVC, sender: nil)
                    LGUserService.sharedService.recordBehavior(behavior: .clickLoanProduct, complete: nil)
                } else {
                    let loginVC = LGLoginViewController()
                    let nc = LGNavigationController(rootViewController: loginVC)
                    present(nc, animated: true, completion: nil)
                }
            } else {
                let detailVC = LGNormalDetailViewController()
                detailVC.model = loanItem
                detailVC.hidesBottomBarWhenPushed = true
                show(detailVC, sender: nil)
                LGUserService.sharedService.recordBehavior(behavior: .clickLoanProduct, complete: nil)
            }
        } else {
            if LGUserModel.currentUser.isLogin {
                let creditItem = model.creditProductArray[indexPath.row]
                let url = URL(string: creditItem.urlString)
                let webVC = RxWebViewController(url: url)!
                webVC.navigationController?.navigationBar.tintColor = kColorTitleText
                webVC.hidesBottomBarWhenPushed = true
                show(webVC, sender: nil)
            } else {
                let loginVC = LGLoginViewController()
                let nc = LGNavigationController(rootViewController: loginVC)
                present(nc, animated: true, completion: nil)
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
}

extension LGHomeViewController: LGRecommendTableViewCellDelegate {
    func recommendTableViewCellDidSelectLeftBanner(cell: LGRecommendTableViewCell) {
        let bannerModel = model.bannerArray[0]
        let loanItem = LGLoanProductModel(bannerModel: bannerModel)
        if loanItem.isRecommended {
            if LGUserModel.currentUser.isLogin {
                let detailVC = LGRecommendDetailViewController()
                detailVC.model = loanItem
                detailVC.hidesBottomBarWhenPushed = true
                show(detailVC, sender: nil)
            } else {
                let loginVC = LGLoginViewController()
                let nc = LGNavigationController(rootViewController: loginVC)
                present(nc, animated: true, completion: nil)
            }
        } else {
            let detailVC = LGNormalDetailViewController()
            detailVC.model = loanItem
            detailVC.hidesBottomBarWhenPushed = true
            show(detailVC, sender: nil)
        }
    }
    
    func recommendTableViewCellDidSelectRightBanner(cell: LGRecommendTableViewCell) {
        let bannerModel = model.bannerArray[1]
        let loanItem = LGLoanProductModel(bannerModel: bannerModel)
        if loanItem.isRecommended {
            if LGUserModel.currentUser.isLogin {
                let detailVC = LGRecommendDetailViewController()
                detailVC.model = loanItem
                detailVC.hidesBottomBarWhenPushed = true
                show(detailVC, sender: nil)
            } else {
                let loginVC = LGLoginViewController()
                let nc = LGNavigationController(rootViewController: loginVC)
                present(nc, animated: true, completion: nil)
            }
        } else {
            let detailVC = LGNormalDetailViewController()
            detailVC.model = loanItem
            detailVC.hidesBottomBarWhenPushed = true
            show(detailVC, sender: nil)
        }
    }
}
