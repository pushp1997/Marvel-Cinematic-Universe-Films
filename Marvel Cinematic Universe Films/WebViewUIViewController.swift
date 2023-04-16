//
//  WebViewUIViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 14/03/2023.
//

import UIKit
import WebKit

class WebViewUIViewController: UIViewController {
    var link: URL!
//    var navtitle: String!
    
    // Outlets
    @IBOutlet weak var wkWebView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView.load(URLRequest.init(url: link))
//        title = navtitle
    }

}
