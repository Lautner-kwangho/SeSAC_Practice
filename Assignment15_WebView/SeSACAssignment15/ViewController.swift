//
//  ViewController.swift
//  SeSACAssignment15
//
//  Created by 최광호 on 2021/10/19.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var destinationURL: String = "apple.com"
    
    @IBOutlet weak var webSearchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webSearchBar.delegate = self
        openWebPage(to: destinationURL)
        
    }
    
    func openWebPage(to urlString: String) {
        var url:String = urlString
        let testURL = url.hasPrefix("http://")
        if !testURL {
            url = "http://" + url
        } else {
            url = destinationURL
        }
        guard let sendToURL = URL(string: url) else {return}
        let request = URLRequest(url: sendToURL)
        webView.load(request)
    }
    
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func reload(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(to: searchBar.text ?? "google.com")
    }
}
