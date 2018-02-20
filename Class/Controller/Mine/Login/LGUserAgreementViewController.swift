//
//  LGWebViewViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import SnapKit
import JavaScriptCore
import RxWebViewController

@objc protocol UserAgreementJSDelegate: JSExport {
    func inform() -> String
}

@objc class UserAgreementJSModel: NSObject, UserAgreementJSDelegate {
    func inform() -> String {
        return "123"
    }
}

class LGUserAgreementViewController: RxWebViewController {
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

//        webView.delegate = self
        loadPage()
    }
    
    private func loadPage() {
        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = UserAgreementJSModel()
        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
    }
}

//extension LGUserAgreementViewController: UIWebViewDelegate {
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
//        let model = UserAgreementJSModel()
//        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
//    }
//}

