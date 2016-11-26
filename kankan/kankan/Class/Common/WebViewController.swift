//
//  WebViewController.swift
//  响巢看看
//
//  Created by qianfeng on 16/10/27.
//  Copyright © 2016年 王鑫. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var webView: UIWebView!
    var urlString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        //创建一个url（网址）
//        print(urlString)
        let url = NSURL(string: urlString)
        //创建一个请求
        let request = NSURLRequest(URL: url!)
        //加载请求
        webView.loadRequest(request)
        
        webView.delegate = self
        view.addSubview(webView)
    
    }


}

extension WebViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        //        print(request.URL?.absoluteString)
       
        return true
    }
    //webView已经加载的时候调用的方法
    func webViewDidStartLoad(webView: UIWebView){
//        print("DidStartLoad")
    }
    //webView已经结束加载的时候调用的方法
    func webViewDidFinishLoad(webView: UIWebView){
//        print("DidFinishLoad")
        //webView执行js的代码,拿到当前网址的title
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        
        self.title = title
        
    }
    //加载失败的时候调用的方法
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        
//        print("didFailLoad")

    }

    
}



