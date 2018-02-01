//
//  LGDropDownMenu.swift
//  LoanGuide
//
//  Created by 喂草。 on 31/01/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

protocol LGDropDownMenuDataSource: class {
    func numberOfSectionFor(dropMenu: LGDropDownMenu) -> Int
    func dropMenu(_ dropMenu: LGDropDownMenu, numberOfRowsInSection section: Int) -> Int
    func dropMenu(_ dropMenu: LGDropDownMenu, titleForRow row: Int, inSection section: Int) -> String
    func dropMenu(_ dropMenu: LGDropDownMenu, contentForRow row: Int, inSection section: Int) -> String?
    func dropMenu(_ dropMenu: LGDropDownMenu, selectedRowForSection section: Int) -> Int
    func dropMenu(_ dropMenu: LGDropDownMenu, setHighLightedForSection section: Int) -> Bool
    func menuHeightFor(dropMenu: LGDropDownMenu) -> CGFloat
}

protocol LGDropDownMenuDelegate: class {
    func dropMenu(_ dropMenu: LGDropDownMenu, didSelectAtSecion section: Int, atRow row: Int)
}

class LGDropDownMenu: UIView {
    weak var delegate: LGDropDownMenuDelegate?
    weak var dataSource: LGDropDownMenuDataSource? {
        didSet {
            buttonCollectionView.reloadData()
        }
    }
    
    private var fatherView: UIView
    private var buttonCollectionView: UICollectionView!
    private var menuTableView: UITableView!
    private var backgroundView: UIView!
    
    private var currentSection: Int!
    
    init(frame: CGRect, fatherView: UIView) {
        self.fatherView = fatherView
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = kColorSeperatorBackground
        
        // 按钮们
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: frame.size.width / 3, height: frame.size.height)
        buttonCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        buttonCollectionView.backgroundColor = UIColor.clear
        buttonCollectionView.bounces = false
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
        buttonCollectionView.register(LGDropBarCollectionViewCell.self,
                                      forCellWithReuseIdentifier: LGDropBarCollectionViewCell.identifier)
        addSubview(buttonCollectionView)
        buttonCollectionView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!)
        }
    }
    
    func reloadData() {
        buttonCollectionView.reloadData()
    }
    
    private func setupMenuTableView() {
        menuTableView = UITableView(frame: CGRect.zero, style: .grouped)
        menuTableView.backgroundView = UIView()
        menuTableView.backgroundView!.backgroundColor = UIColor.clear
        menuTableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        menuTableView.isScrollEnabled = false
        menuTableView.isHidden = true
        menuTableView.backgroundView!.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(menuBackgroundOnClick))
        menuTableView.backgroundView!.addGestureRecognizer(tapGR)
        menuTableView.register(LGDropMenuTableViewCell.self, forCellReuseIdentifier: LGDropMenuTableViewCell.identifier)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        fatherView.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { [weak self] make in
            make.left.right.equalTo(self!)
            make.top.equalTo(self!.snp.bottom)
            make.height.equalTo(dataSource!.menuHeightFor(dropMenu: self!))
        }
    }
    
    private func showMenu() {
        if menuTableView == nil {
            setupMenuTableView()
        }
        menuTableView.reloadData()
        menuTableView.isHidden = false
    }
    
    private func hideMenu() {
        if menuTableView == nil {
            setupMenuTableView()
        }
        menuTableView.isHidden = true
    }
    
    @objc private func menuBackgroundOnClick() {
        hideMenu()
    }
}

//MARK:- UICollectionView delegate, datasource
extension LGDropDownMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let source = dataSource {
            return source.numberOfSectionFor(dropMenu: self)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let source = dataSource!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LGDropBarCollectionViewCell.identifier, for: indexPath) as! LGDropBarCollectionViewCell
        let selectedRow = source.dropMenu(self, selectedRowForSection: indexPath.row)
        let title = source.dropMenu(self, titleForRow: selectedRow, inSection: indexPath.row)
        cell.configCell(title: title, highlighted: source.dropMenu(self, setHighLightedForSection: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let source = dataSource {
            if source.dropMenu(self, numberOfRowsInSection: indexPath.row) > 1 {
                if menuTableView == nil {
                    currentSection = indexPath.row
                    showMenu()
                } else if currentSection == indexPath.row && menuTableView.isHidden == false {
                    currentSection = indexPath.row
                    hideMenu()
                } else {
                    currentSection = indexPath.row
                    showMenu()
                }
            } else {
                delegate?.dropMenu(self, didSelectAtSecion: indexPath.row, atRow: 0)
                currentSection = indexPath.row
                hideMenu()
            }
        }
    }
}

//MARK:- UITableView delegate, datasource
extension LGDropDownMenu: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let source = dataSource {
            return source.dropMenu(self, numberOfRowsInSection: currentSection)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let source = dataSource {
            let cell = tableView.dequeueReusableCell(withIdentifier: LGDropMenuTableViewCell.identifier) as! LGDropMenuTableViewCell
            let title = source.dropMenu(self, titleForRow: indexPath.row, inSection: currentSection)
            let content = source.dropMenu(self, contentForRow: indexPath.row, inSection: currentSection)
            cell.configCell(title: title, content: content)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dropMenu(self, didSelectAtSecion: currentSection, atRow: indexPath.row)
        hideMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
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
