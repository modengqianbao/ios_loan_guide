//
//  LGCreditZhimaViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 14/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import JavaScriptCore
import RxWebViewController

@objc protocol ZhimaJSDelegate: JSExport {
    func inform() -> String
}

@objc class ZhimaJSModel: NSObject, ZhimaJSDelegate {
    func inform() -> String {
        print("123")
        
        return "123"
    }
}

class LGCreditZhimaViewController: RxWebViewController {
    private var jsContext: JSContext!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        url = URL(string: kUserAgreementURLString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage()
    }
    
    private func loadPage() {
        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = UserAgreementJSModel()
        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
    }
}
