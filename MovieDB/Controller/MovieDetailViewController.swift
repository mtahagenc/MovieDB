//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 24.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailViewController: UIViewController {

    var selectedMovie : Int?
    var videoModel :VideosModel? = nil
    var movieDetail : MovieDetailModel? = nil {
        didSet {         self.posterImageView.setImageWithKF("\(URLs().baseImageURL)\((self.movieDetail?.poster_path)!)")
            self.aboutMovieTextView.text = self.movieDetail?.overview
            self.label1.text = self.movieDetail?.original_title
            self.label2.text = self.movieDetail?.homepage ?? ""
            self.label3.text = "IMDB ranking : \(self.movieDetail?.vote_average ?? 0)"
        }
    }
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var aboutMovieTextView: UITextView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    //MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovioesDetail(url: "\(URLs().baseURL)/movie/\(selectedMovie!)\(URLs().API_key)")
        getMoviesVideo(url: "\(URLs().baseURL)/movie/\(selectedMovie!)/videos\(URLs().API_key)")
        layouts()
    }
    
    //MARK: - Functions
    
    func layouts () {
        posterImageView.layer.cornerRadius = 8
    }
    
    func getMovioesDetail (url: String) {
        WebServices().get(url) { (type, model : MovieDetailModel?) in
            switch type {
            case .Succeed :
                self.movieDetail = model
            case .Failed : print("Failed")
            case .FailedDecode : print("FailedDecode")
            default : break
            }
        }
    }
    
    func getMoviesVideo (url: String) {
        WebServices().get(url) { (type, model: VideosModel?) in
            switch type {
            case .Succeed :
                self.videoModel = model
                print("\(URLs().baseVideoURL)\((self.videoModel?.results[0].key)!)")
                self.playVideo(url: "\(URLs().baseVideoURL)\((self.videoModel?.results[0].key)!)")
            case .Failed : print("getMoviesVideo Failed")
            case .FailedDecode: print("getMoviesVideo FailedDecode")
            default : break
            }
        }
    }
    
    func playVideo (url: String) {
        let url = URL(string: url)

        let request = URLRequest(url: url!)

        webView.loadRequest(request)
    }
    
}
