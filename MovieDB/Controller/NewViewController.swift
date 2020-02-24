//
//  NewViewController.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 27.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playVideo()
    }
    
    func playVideo () {
        let url = URL(string: "https://www.youtube.com/embed/9bZkp7q19f0")

        let request = URLRequest(url: url!)

        webView.loadRequest(request)
    }
}
