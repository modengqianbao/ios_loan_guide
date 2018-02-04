//
//  LGRecordViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGRecordViewController: UIViewController {
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
            tableView.backgroundColor = kColorSeperatorBackground
            if index == 0 {
                // 贷款
                tableView.register(LGHotProductTableViewCell.self,
                                   forCellReuseIdentifier: LGHotProductTableViewCell.identifier)
            } else {
                // 信用卡
                tableView.register(LGCreditCardTableViewCell.self,
                                   forCellReuseIdentifier: LGCreditCardTableViewCell.identifier)
            }
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
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewArray[0] {
            // 贷款列表
            let cell = tableView.dequeueReusableCell(withIdentifier: LGHotProductTableViewCell.identifier) as! LGHotProductTableViewCell
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dateView(date: "2018年02月04日")
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

