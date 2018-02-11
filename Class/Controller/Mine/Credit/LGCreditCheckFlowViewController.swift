//
//  LGCreditCheckFlowViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 07/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGCreditCheckFlowViewController: LGViewController {
    private var flowTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        title = "信用知多少"
        view.backgroundColor = kColorBackground
        
        flowTableView = UITableView(frame: CGRect.zero, style: .grouped)
        flowTableView.separatorStyle = .none
        flowTableView.backgroundColor = kColorSeperatorBackground
        flowTableView.register(LGCreditCheckFlowTableViewCell.self,
                               forCellReuseIdentifier: LGCreditCheckFlowTableViewCell.identifier)
        flowTableView.register(LGCreditCheckInfoTableViewCell.self,
                               forCellReuseIdentifier: LGCreditCheckInfoTableViewCell.identifier)
        flowTableView.register(LGNormalDetailApplyTableViewCell.self,
                               forCellReuseIdentifier: LGNormalDetailApplyTableViewCell.identifier)
        flowTableView.dataSource = self
        flowTableView.delegate = self
        view.addSubview(flowTableView)
        flowTableView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!.view)
        }
    }
    
    private func headView(withTitle title: String) -> UIView {
        let head = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        head.backgroundColor = kColorBackground
        let label = UILabel()
        label.textColor = kColorTitleText
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = title
        head.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 0))
        }
        
        let line = UIView()
        line.backgroundColor = kColorSeperatorBackground
        head.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(head)
            make.height.equalTo(1)
        }
        
        return head
    }
    
    private func showVerificationVC() {
        let verificationVC = LGCreditCheckVericationViewController()
        show(verificationVC, sender: nil)
    }
}

extension LGCreditCheckFlowViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckFlowTableViewCell.identifier)!            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGCreditCheckInfoTableViewCell.identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailApplyTableViewCell.identifier) as! LGNormalDetailApplyTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            cell.configCell(title: "申请查询")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 2 {
            return 40
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return headView(withTitle: "查询流程")
        } else if section == 1 {
            return headView(withTitle: "功能介绍")
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension LGCreditCheckFlowViewController: LGNormalDetailApplyTableViewCellDelegate {
    func applyCellDidSubmit(_ applyCell: LGNormalDetailApplyTableViewCell) {
        showVerificationVC()
    }
}
