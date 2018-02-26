//
//  LGMessageViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class LGMessageViewController: UIViewController {
    /// 必须传入
    var model: LGMineModel!
    
    private var messageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        title = "消息中心"
        view.backgroundColor = kColorBackground
        
        messageTableView = UITableView(frame: CGRect.zero, style: .grouped)
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 80
        messageTableView.separatorStyle = .none
        messageTableView.backgroundColor = kColorSeperatorBackground
        messageTableView.register(LGMessageTableViewCell.self,
                                  forCellReuseIdentifier: LGMessageTableViewCell.identifier)
        messageTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self!.model.reloadMessages { hasMore, error in
                if self != nil {
                    self!.messageTableView.mj_header.endRefreshing()
                    self!.messageTableView.reloadData()
                    self!.messageTableView.mj_footer.isHidden = false
                    if error == nil {
                        if hasMore {
                            self!.messageTableView.mj_footer.endRefreshing()
                        } else {
                            self!.messageTableView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        LGHud.show(in: self!.view, animated: true, text: error)
                    }
                }
            }
        })
        messageTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self!.model.loadMoreMessages(complete: { hasMore, error in
                if self != nil {
                    if error == nil {
                        self!.messageTableView.reloadData()
                        if hasMore {
                            self!.messageTableView.mj_footer.endRefreshing()
                        } else {
                            self!.messageTableView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        self!.messageTableView.mj_footer.endRefreshing()
                    }
                }
            })
        })
        messageTableView.mj_footer.isHidden = true
        messageTableView.delegate = self
        messageTableView.dataSource = self
        view.addSubview(messageTableView)
        messageTableView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!.view)
        }
    }
    
    private func getMessages() {
        if model.messageArray != nil {
            return
        }
        
        messageTableView.mj_header.beginRefreshing()
    }
}

//MARK:- UITableView delegate, datasource
extension LGMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = model.messageArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LGMessageTableViewCell.identifier) as! LGMessageTableViewCell
        let message = model.messageArray![indexPath.row]
        cell.configCell(dateString: message.dateString,
                        title: message.title,
                        content: message.content)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
