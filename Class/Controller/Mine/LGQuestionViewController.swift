//
//  LGQuestionViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 03/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class LGQuestionViewController: UIViewController {
    /// 必须传入
    var model: LGMineModel!
    
    private var questionTableView: UITableView!
    
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        getQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        title = "常见问题"
        view.backgroundColor = kColorBackground
        
        questionTableView = UITableView(frame: CGRect.zero, style: .grouped)
        questionTableView.rowHeight = UITableViewAutomaticDimension
        questionTableView.estimatedRowHeight = 80
        questionTableView.separatorStyle = .none
        questionTableView.backgroundColor = kColorSeperatorBackground
        questionTableView.register(LGQuestionHeaderTableViewCell.self,
                                   forCellReuseIdentifier: LGQuestionHeaderTableViewCell.identifier)
        questionTableView.register(LGQuestionQuestionTableViewCell.self,
                                   forCellReuseIdentifier: LGQuestionQuestionTableViewCell.identifier)
        questionTableView.register(LGQuestionContentTableViewCell.self,
                                   forCellReuseIdentifier: LGQuestionContentTableViewCell.identifier)
        questionTableView.delegate = self
        questionTableView.dataSource = self
        view.addSubview(questionTableView)
        questionTableView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!.view)
        }
    }
    
    private func getQuestions() {
        if model.questionArray != nil {
            // 已经请求过了
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        LGMineService.sharedService.getQuestions { [weak self] array, error in
            if self != nil {
                MBProgressHUD.hide(for: self!.view, animated: true)
                if error == nil {
                    // 问题根据头标归类
                    var questionDic = [String: [LGQuestionModel]]()
                    for questionItem in array! {
                        if var questionArray = questionDic[questionItem.header] {
                            questionArray.append(questionItem)
                            questionDic[questionItem.header] = questionArray
                        } else {
                            var questionArray = [LGQuestionModel]()
                            questionArray.append(questionItem)
                            questionDic[questionItem.header] = questionArray
                        }
                    }
                    // 初始化model
                    self!.model.questionArray = [[LGQuestionModel]]()
                    self!.model.questionHeaderArray = [String]()
                    for (header, questionArray) in questionDic {
                        self!.model.questionHeaderArray!.append(header)
                        self!.model.questionArray!.append(questionArray)
                    }
                    // 刷新列表
                    self!.questionTableView.reloadData()
                } else {
                    LGHud.show(in: self!.view, animated: true, text: error)
                }
            }
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let array = model.questionArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = model.questionArray {
            if selectedIndexPath != nil && section == selectedIndexPath!.section {
                return array[section].count + 2
            } else {
                return array[section].count + 1
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // 标头
            let cell = tableView.dequeueReusableCell(withIdentifier: LGQuestionHeaderTableViewCell.identifier) as! LGQuestionHeaderTableViewCell
            let title = model.questionHeaderArray![indexPath.section]
            cell.configCell(title: title)
            return cell
        } else if selectedIndexPath != nil
            && indexPath.section == selectedIndexPath!.section
            && indexPath.row == selectedIndexPath!.row + 1 {
            // 回答
            let cell = tableView.dequeueReusableCell(withIdentifier: LGQuestionContentTableViewCell.identifier) as! LGQuestionContentTableViewCell
            let questionItem = model.questionArray![indexPath.section][indexPath.row - 2]
            cell.configCell(content: questionItem.content)
            return cell
        } else {
            // 问题
            let cell = tableView.dequeueReusableCell(withIdentifier: LGQuestionQuestionTableViewCell.identifier) as! LGQuestionQuestionTableViewCell
            var row: Int
            if selectedIndexPath != nil
                && indexPath.section == selectedIndexPath!.section
                && indexPath.row > selectedIndexPath!.row {
                row = indexPath.row - 2
            } else {
                row = indexPath.row - 1
            }
            let question = model.questionArray![indexPath.section][row].matter
            if selectedIndexPath != nil && indexPath.section == selectedIndexPath!.section && indexPath.row == selectedIndexPath!.row {
                cell.configSelect(selected: true)
            } else {
                cell.configSelect(selected: false)
            }
            cell.configCell(question: question)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            if selectedIndexPath != nil {
                if indexPath.section == selectedIndexPath!.section
                    && indexPath.row == selectedIndexPath!.row {
                    // 点击已选择的问题
                    selectedIndexPath = nil
                    tableView.reloadData()
                } else if indexPath.section == selectedIndexPath!.section
                    && indexPath.row == selectedIndexPath!.row + 1 {
                    // 点击展开的问题
                } else {
                    // 点击其他问题
                    if indexPath.section == selectedIndexPath!.section && indexPath.row > selectedIndexPath!.row {
                        selectedIndexPath = IndexPath(row: indexPath.row - 1,
                                                      section: indexPath.section)
                        tableView.reloadData()
                    } else {
                        selectedIndexPath = indexPath
                        tableView.reloadData()
                    }
                }
            } else {
                // 首次选择一个问题
                selectedIndexPath = indexPath
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
