//
//  LGCreditZhimaViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 14/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import JavaScriptCore
//import RxWebViewController

//@objc protocol ZhimaJSDelegate: JSExport {
//    func inform() -> String
//    func jsUseNative(parameters: String, sign: String)
//}
//
//@objc class ZhimaJSModel: NSObject, ZhimaJSDelegate {
//    func inform() -> String {
//        return "123"
//    }
//
//    func jsUseNative(parameters: String, sign: String) {
//        print("arg1:\(parameters),\narg2:\(sign)")
//    }
//}

protocol LGCreditZhimaViewControllerDelegate: class {
    func zhimaVCDidGetAuth(_ zhimaVC: LGCreditZhimaViewController)
}

class LGCreditZhimaViewController: RxWebViewController {
    
    weak var delegate: LGCreditZhimaViewControllerDelegate?
    
    private var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self        
    }
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    private func getAuth(params: String, sign: String) {
        LGCreditCheckModel.sharedModel.getZhimaAuth(params: params, sign: sign)
        navigationController?.popViewController(animated: true)
        delegate?.zhimaVCDidGetAuth(self)
    }
}

extension LGCreditZhimaViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url!.absoluteString.hasPrefix("http://wallet.cdxiaoshudian.com/test_result") {
            let urlString = request.url!.absoluteString
            
            let parameters = getQueryStringParameter(url: urlString, param: "params")!
            let sign = getQueryStringParameter(url: urlString, param: "sign")!
            getAuth(params: parameters, sign: sign)
            
//            jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
//            let model = ZhimaJSModel()
//            jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
            return false
        } else {
            return true
        }
    }
}

