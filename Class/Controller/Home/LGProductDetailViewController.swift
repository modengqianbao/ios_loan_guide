//
//  LGProductDetailViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 01/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGProductDetailViewController: LGViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        title = "产品详情"
        
        let detailTableView = UITableView(frame: CGRect.zero, style: .grouped)
        detailTableView.backgroundColor = kColorSeperatorBackground
        detailTableView.showsVerticalScrollIndicator = false
        detailTableView.separatorStyle = .none
        detailTableView.register(LGRecommendTitleTableViewCell.self,
                                 forCellReuseIdentifier: LGRecommendTitleTableViewCell.identifier)
        detailTableView.register(LGNormalDetailContentTableViewCell.self,
                                 forCellReuseIdentifier: LGNormalDetailContentTableViewCell.identifier)
        detailTableView.register(LGProductDetailFlowTableViewCell.self,
                                 forCellReuseIdentifier: LGProductDetailFlowTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { [weak self] make in
            make.left.right.bottom.top.equalTo(self!.view)
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 5
        } else if section == 2 {
            return 2
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 产品介绍
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "产品介绍")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: "房中到分开恨着我的范我爱我出去很is当发is当发我has第复合物吃嗯好IP长个我中扥hipwe很我很无耻喷雾IE很 ")
                return cell
            }
        } else if indexPath.section == 1 {
            // 贷款流程
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "贷款流程")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGProductDetailFlowTableViewCell.identifier) as! LGProductDetailFlowTableViewCell
                cell.configCell(number: indexPath.row, type: .middle, content: "沟里国家生死")
                return cell
            }
        } else if indexPath.section == 2 {
            // 申请条件
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "申请条件")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGNormalDetailContentTableViewCell.identifier) as! LGNormalDetailContentTableViewCell
                cell.configCell(content: "18-35周岁")
                return cell
            }
        } else {
            // 审核说明
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: LGRecommendTitleTableViewCell.identifier) as! LGRecommendTitleTableViewCell
                cell.configCell(title: "审核说明")
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 12
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
