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
    func jsUseNative(arg1: String, arg2: String)
}

@objc class ZhimaJSModel: NSObject, ZhimaJSDelegate {
    func inform() -> String {
        return "123"
    }
    
    func jsUseNative(arg1: String, arg2: String) {
        print("arg1:\(arg1),\narg2:\(arg2)")
    }
}

class LGCreditZhimaViewController: RxWebViewController {
    private var jsContext: JSContext!
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//        url = URL(string: kUserAgreementURLString)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
//        loadPage()
    }
    
//    private func loadPage() {
//        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
//        let model = ZhimaJSModel()
//        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
//    }
}

extension LGCreditZhimaViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = ZhimaJSModel()
        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))

    }
}

