//
//  InfoVC.swift
//  BrowserApp
//
//  Created by Akniyet Just on 24.10.2021.
//

import UIKit
import WebKit

protocol CharactersProtocol {
    func addFavourite(name: String, webView: String)
}

class InfoVC: UIViewController {

    var url = URL(string: "https://www.google.com")
    var myProtocol: CharactersProtocol?
    var name = ""
    var myView = UIView()
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height / 10 - 50, width: UIScreen.main.bounds.width, height: 150))
        myView.backgroundColor = .gray
        view.addSubview(myView)
        
        let myRequest = URLRequest(url: url!)
        webview.load(myRequest)
        
        
        let touch = UITapGestureRecognizer()
        touch.addTarget(self, action: #selector(handlerTapGester))
        
        self.view.addGestureRecognizer(touch)
    }
    
    @objc func handlerTapGester() {
        self.navigationController?.navigationBar.backgroundColor = .yellow
        myProtocol?.addFavourite(name: name, webView: url!.absoluteString)
    }
}

extension UIImageView {
    func circle() -> UIImageView {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.bounds.width / 2
        
        return self
    }
}
