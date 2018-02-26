//
//  LGRecordViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
//import RxWebViewController

class LGRecordViewController: LGViewController {
    /// 传入
    var model: LGMineModel!
    
    private var segmentControl: UISegmentedControl!
    private var recordCollectionView: UICollectionView!
    
    private let titleArray = ["贷款", "信用卡"]
    private var tableViewArray: [UITableView]!
    private let collectionViewCellIdentifier = "collectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        title = "申请记录"
        view.backgroundColor = kColorBackground
        
        let whiteView = UIView()
        whiteView.backgroundColor = kColorBackground
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view.snp.top)
            make.height.equalTo(64)
        }
        
        // 选择框
        let segmentViewHeight = CGFloat(50)

        let segmentView = UIView()
        segmentView.backgroundColor = kColorSeperatorBackground
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { [weak self] make in
            make.left.right.top.equalTo(self!.view)
            make.height.equalTo(segmentViewHeight)
        }

        segmentControl = UISegmentedControl(items: titleArray)
        segmentControl.tintColor = kColorMainTone
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChange), for: .valueChanged)
        segmentView.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.center.equalTo(segmentView)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        // collectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth,
                                 height: kScreenHeight - 64 - segmentViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        recordCollectionView = UICollectionView(frame: CGRect(x: 0,
                                                                  y: segmentViewHeight,
                                                                  width: view.frame.size.width,
                                                                  height: view.frame.size.height - segmentViewHeight), collectionViewLayout: layout)
        recordCollectionView.register(UICollectionViewCell.self,
                                      forCellWithReuseIdentifier: collectionViewCellIdentifier)
        recordCollectionView.showsHorizontalScrollIndicator = true
        recordCollectionView.isPagingEnabled = true
        recordCollectionView.bounces = false
        recordCollectionView.dataSource = self
        recordCollectionView.delegate = self
        view.addSubview(recordCollectionView)
        recordCollectionView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(segmentView.snp.bottom)
        }
        
        // 列表
        tableViewArray = [UITableView]()
        for index in 0..<titleArray.count {
            let tableView = UITableView(frame: CGRect.zero, style: .grouped)
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 80
            tableView.backgroundColor = kColorSeperatorBackground
            if index == 0 {
                // 贷款
                tableView.register(LGHotProductTableViewCell.self,
                                   forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
                tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
                    self!.model.reloadLoanProduct { hasMore, error in
                        if self != nil {
                            tableView.mj_footer.isHidden = false
                            tableView.mj_header.endRefreshing()
                            if error == nil {
                                tableView.reloadData()
                                if hasMore {
                                    tableView.mj_footer.endRefreshing()
                                } else {
                                    tableView.mj_footer.endRefreshingWithNoMoreData()
                                }
                            } else {
                                LGHud.show(in: self!.view, animated: true, text: error)
                            }
                        }
                    }
                })
                tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
                    self!.model.loadLoanProduct { hasMore, error in
                        if self != nil {
                            if error == nil {
                                tableView.reloadData()
                                if hasMore {
                                    tableView.mj_footer.endRefreshing()
                                } else {
                                    tableView.mj_footer.endRefreshingWithNoMoreData()
                                }
                            } else {
                                LGHud.show(in: self!.view, animated: true, text: error)
                            }
                        }
                    }
                })
            } else {
                // 信用卡
                tableView.register(LGCreditCardTableViewCell.self,
                                   forCellReuseIdentifier: LGCreditCardTableViewCell.identifier)
                tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
                    self!.model.reloadCreditProduct { hasMore, error in
                        if self != nil {
                            tableView.mj_footer.isHidden = false
                            tableView.mj_header.endRefreshing()
                            if error == nil {
                                tableView.reloadData()
                                if hasMore {
                                    tableView.mj_footer.endRefreshing()
                                } else {
                                    tableView.mj_footer.endRefreshingWithNoMoreData()
                                }
                            } else {
                                LGHud.show(in: self!.view, animated: true, text: error)
                            }
                        }
                    }
                })
                tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
                    self!.model.loadCreditProduct { hasMore, error in
                        if self != nil {
                            if error == nil {
                                tableView.reloadData()
                                if hasMore {
                                    tableView.mj_footer.endRefreshing()
                                } else {
                                    tableView.mj_footer.endRefreshingWithNoMoreData()
                                }
                            } else {
                                LGHud.show(in: self!.view, animated: true, text: error)
                            }
                        }
                    }
                })
            }
            tableView.mj_footer.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableViewArray.append(tableView)
        }
    }
    
    private func dateView(date: String) -> UIView {
        let dateView = UIView()
        dateView.backgroundColor = UIColor.clear
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        dateLabel.textAlignment = .center
        dateLabel.textColor = kColorTitleText
        dateLabel.text = date
        dateView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        return dateView
    }
    
    @objc private func segmentValueChange(segmentControl: UISegmentedControl) {
        recordCollectionView.scrollToItem(at: IndexPath(item: segmentControl.selectedSegmentIndex, section: 0), at: .left, animated: true)
    }
}

//2MARK:- UITableView delegate, datasource
extension LGRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewArray[0] {
            if model.loanArray != nil {
                return model.loanArray!.count
            } else {
                return 0
            }
        } else {
            if model.creditArray != nil {
                return model.creditArray!.count
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewArray[0] {
            let array = model.loanArray![section]
            return array.count
        } else {
            let array = model.creditArray![section]
            return array.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewArray[0] {
            // 贷款列表
            let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
            let loanItem = model.loanArray![indexPath.section][indexPath.row]
            let moneyString = "日利率: \(loanItem.rateMax)%, 额度: \(loanItem.loanMax)元"
            cell.configCell(iconURLString: kImageDomain.appending(loanItem.logoString),
                            title: loanItem.name,
                            adString: loanItem.labelString,
                            moneyString: moneyString,
                            describeString: loanItem.loanSpec)
            return cell
        } else {
            // 信用卡列表
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCardTableViewCell.identifier) as! LGCreditCardTableViewCell
            let creditItem = model.creditArray![indexPath.section][indexPath.row]
            cell.configCell(iconURLString: kImageDomain.appending(creditItem.logoURL),
                            title: creditItem.name,
                            content: creditItem.introduce,
                            extra: creditItem.label)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewArray[0] {
            let item = model.loanArray![indexPath.section][indexPath.row]
            if item.isRecommended {
                let detailVC = LGRecommendDetailViewController()
                detailVC.hidesBottomBarWhenPushed = true
                detailVC.model = item
                show(detailVC, sender: nil)
            } else {
                let detailVC = LGNormalDetailViewController()
                detailVC.hidesBottomBarWhenPushed = true
                detailVC.model = item
                show(detailVC, sender: nil)
            }
        } else {
            let item = model.creditArray![indexPath.section][indexPath.row]
            let todo = 1
//            let url = URL(string: item.urlString)
//            let webVC = RxWebViewController(url: url)!
//            webVC.navigationController?.navigationBar.tintColor = kColorTitleText
//            webVC.hidesBottomBarWhenPushed = true
            
//            navigationController?.pushViewController(webVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableViewArray[0] {
            if model.loanDateStringArray != nil {
                let dateString = model.loanDateStringArray![section]
                return dateView(date: dateString)
            } else {
                return nil
            }
        } else {
            if model.creditDateStringArray != nil {
                let dateString = model.creditDateStringArray![section]
                return dateView(date: dateString)
            } else {
                return nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

//MARK:- UICollectionView datasource
extension LGRecordViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath)
        if cell.contentView.subviews.count == 0 {
            // 添加列表
            let tableView = tableViewArray[indexPath.row]
            cell.contentView.addSubview(tableView)
            tableView.snp.makeConstraints({ make in
                make.left.right.top.bottom.equalTo(cell.contentView)
            })
            tableView.mj_header.beginRefreshing()
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == recordCollectionView {
            let offsetMiddle = kScreenWidth / 2
            let offsetX = scrollView.contentOffset.x
            if offsetX < offsetMiddle {
                segmentControl.selectedSegmentIndex = 0
            } else {
                segmentControl.selectedSegmentIndex = 1
            }
        } else {
            return
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == recordCollectionView {
            let offsetMiddle = kScreenWidth / 2
            let offsetX = scrollView.contentOffset.x
            if offsetX < offsetMiddle {
                segmentControl.selectedSegmentIndex = 0
            } else {
                segmentControl.selectedSegmentIndex = 1
            }
        } else {
            return
        }
    }
}

