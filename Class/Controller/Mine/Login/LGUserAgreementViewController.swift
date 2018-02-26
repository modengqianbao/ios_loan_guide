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
//import RxWebViewController

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
        
//        url = URL(string: "http://wallet.cdxiaoshudian.com/test_result?params=EbGqosDO5YWKV9tOVYUNUD6O0vPpfjk4o6AWSIvE3%2BWF%2BphUyOzYco8wFHmvhjxQkP4sr13CIJ6PqPpFGYZpraJ86LSHuFLxx%2FL3PVuBdWxhUvvy3ukGvpkm8ETVYWq%2Fj7uwog6l2SwHdU%2F%2FGpswYvfZVQUjw5e4PUKfPveP2o6%2BGqn%2FE%2BtIvO%2BnDLKE9L%2BdwvPGp%2FY1NBvIiRWB7yACQy6%2Fu8WyCi03xdreWGrdGc8usuzJaTInjR8i%2F72FRUSYPhzkbtHVlnuelEenel%2BB0lMPURil1%2B6NRYgxXo3PfMGr1OdAWpqGjJWPYnF0JDxwLGtwZD7s2PRVaqELd4H68WR6hzEWQJs6Pu3pptUusRNYe6HWHl1WsWyPvzIHpOnLg%2FG6KOmwNeJ%2FvXLFt9qhFKNa6jMild2O6NtluiRkeunL0KZPwSYlq%2B9XLoHEbB2c9IN4TzX6DIwXF6eurcviqCtLvSeiBxw1H2OeBdaEMI3It2AE597CrnIah52w5Tu2&sign=mLmF1B3fT%2BKKTw2B6bg550Vty4Fo%2FJXkji63SN8YVb7ztzQGEdm8S4JqlgYTjWu1s%2B%2FLjxBVgl91tCBdprqchutWafYo9c6aGvlz5IMf4qtg2yo1iFPMipvOiLJ7pbN%2FVGchvPcrP1JxTWnompRsDyC2U0JCPKMP1EIeabub5JE%3D")
        url = URL(string: kUserAgreementURLString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
//        loadPage()
    }
    
//    private func loadPage() {
//        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
//        let model = UserAgreementJSModel()
//        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
//    }
}

extension LGUserAgreementViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = UserAgreementJSModel()
        jsContext.setObject(model, forKeyedSubscript: NSString(string: "callAndroid"))
        
        return true
    }
}

