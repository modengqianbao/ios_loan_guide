//
//  LGWebViewViewController.swift
//  LoanGuide
//
//  Created by 喂草。 on 04/02/2018.
//  Copyright © 2018 Zhishu. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import JavaScriptCore
import WebViewBridge_Swift
//import WebViewJavascriptBridge

@objc protocol SwiftJavaScriptDelegate: JSExport {
    func callAndroid() -> String
}

@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    func callAndroid() -> String {
        return "123"
    }
}

class LGWebViewViewController: LGViewController {
    /// 传入
    var webTitle: String?
    var urlString: String!
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
//    private var bridge: WebViewJavascriptBridge!
    private var jsContext: JSContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadPage()
    }
    
    private func setup() {
        view.backgroundColor = kColorBackground
        title = webTitle
        
        webView = WKWebView()
//        webView.delegate = self
        view.addSubview(webView)
        webView.snp.makeConstraints { [weak self] make in
            make.left.right.top.bottom.equalTo(self!.view)
        }

        let bridge = ZHWebViewBridge.bridge(webView)
        bridge.registerHandler("callAndroid") { (args:[Any]) -> (Bool, [Any]?) in
            return (true, ["123"])
        }
        // 进度条
//        progressView = UIProgressView(progressViewStyle: .default)
//        progressView.trackTintColor = UIColor.clear
//        progressView.progressTintColor = kColorMainTone
//        view.addSubview(progressView)
//        progressView.snp.makeConstraints { [weak self] make in
//            make.left.right.top.equalTo(self!.view)
//            make.height.equalTo(2)
//        }
        
        // bridge
//        bridge = WebViewJavascriptBridge(forWebView: webView)
//        bridge.registerHandler("callAndroid") { data, responseCallBack in
//            if responseCallBack != nil {
//                responseCallBack!("123")
//            }
//            print(data!)
//        }
//        bridge.callHandler("callAndroid", data: nil) { responseData in
//            print(responseData!)
//        }
//        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext")!
//        context["callAndroid"] = {
//            return "123"
//        }
    }
    
    private func loadPage() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
extension LGWebViewViewController: WKNavigationDelegate, WKUIDelegate {
    
}

extension LGWebViewViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        self.jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = SwiftJavaScriptModel()
        model.controller = self
        model.jsContext = self.jsContext
        
        // 这一步是将SwiftJavaScriptModel模型注入到JS中，在JS就可以通过WebViewJavascriptBridge调用我们暴露的方法了。
        self.jsContext.setObject(model, forKeyedSubscript: NSString(string: "native"))
        
        // 注册到本地的Html页面中
//        let url = Bundle.main.url(forResource: "demo", withExtension: "html")
//        JSContext.evaluateScript(<#T##JSContext#>)
//        self.jsContext.evaluateScript(try? String(contentsOf: url!, encoding: String.Encoding.utf8))
        
        // 注册到网络Html页面 请设置允许Http请求
        let curUrl = webView.request?.url?.absoluteString    //WebView当前访问页面的链接 可动态注册
        self.jsContext.evaluateScript(try! String(contentsOf: URL(string: curUrl!)!, encoding: String.Encoding.utf8))
        
        self.jsContext.exceptionHandler = { (context, exception) in
            print("exception：", exception as Any)
        }
    }
}

