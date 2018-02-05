//
//  LGNormalDetailFlowTableViewCell.swift
//  LoanGuide
//
//  Created by 喂草。 on 05/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit

class LGNormalDetailFlowTableViewCell: UITableViewCell {
    static let identifier = "LGNormalDetailFlowTableViewCell"
    
    private var flowCollectionView: UICollectionView!
    
    private var flowArray: [LGLoanFlowModel]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = kColorBackground
        selectionStyle = .none
        
        let itemHeight = CGFloat(50)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth / 4 - 4,
                                 height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = CGSize(width: 12, height: itemHeight)
        flowCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        flowCollectionView.backgroundColor = kColorBackground
        flowCollectionView.showsHorizontalScrollIndicator = false
        flowCollectionView.register(LGNormalDetailFlowCollectionViewCell.self,
                                    forCellWithReuseIdentifier: LGNormalDetailFlowCollectionViewCell.identifier)
        contentView.addSubview(flowCollectionView)
        flowCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
            make.height.equalTo(itemHeight)
        }
        flowCollectionView.dataSource = self
    }
    
    func configCell(flowArray: [LGLoanFlowModel]?) {
        self.flowArray = flowArray
        flowCollectionView.reloadData()
    }
}

extension LGNormalDetailFlowTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if flowArray == nil {
            return 0
        } else {
            return flowArray!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LGNormalDetailFlowCollectionViewCell.identifier,
                                                      for: indexPath) as! LGNormalDetailFlowCollectionViewCell
        let flowItem = flowArray![indexPath.row]
        cell.configCell(number: flowItem.order,
                        title: flowItem.name,
                        showArrow: indexPath.row < flowArray!.count - 1)
        
        return cell
    }
}
