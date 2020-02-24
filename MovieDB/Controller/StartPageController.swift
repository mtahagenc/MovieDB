//
//  StartPageController.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 11.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import UIKit

class StartPageController: UIViewController {

    //MARK: - Constants and Variables
    
    var nowPlayingModel : MoviesModel? = nil
    var trendingMoviesModel : MoviesModel? = nil
    
    //MARK: - Outlets
    
    @IBOutlet weak var nowPlayingColVi: UICollectionView!
    
    @IBOutlet weak var trendingMoviesColVi: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUpcomingMovies(url: "\(URLs().baseURL)\(URLs().upComingURL)\(URLs().API_key)")
        getNowPlayingMovies(url: "\(URLs().baseURL)\(URLs().nowPlayingURL)\(URLs().API_key)")
    }
    
    //MARK: - Navigation
    
    // prepare for segue fonksiyonu birinci controllerdan ikinci controllera veri aktarmaya yarar.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! MovieDetailViewController
        // burada hedef viewController'in hangisini oldugunu belirledik.
        
        let cell = sender as! UICollectionViewCell
        // diger viewController'a hangi verinin aktarilacagini anlamak icin hangi indexPath'in secildigini bilmemiz gerektiginden oturu bir cell tanimlamamiz gerekir. TableViewController'da asagidaki indexPath(for: cell) metodu yerine selectedRowAtIndexPath metodunu kullaniriz.
        
        if segue.identifier == "showNowPlayingMovieDetail" {
            let indexPath = self.nowPlayingColVi!.indexPath(for: cell)
            destinationVC.selectedMovie = nowPlayingModel?.results?[indexPath!.row].id
            // hedef viewController'i belirledikten ve indexPath'i belirledikten sonra birinci controllerdan ikinci contrellera gondermek istedigimiz veriyi secerek gonderiyoruz. burada destinationVC'nin selectedMovie degiskenini indexPath.row ile degistirdik.
        } else {
            let indexPath = self.trendingMoviesColVi!.indexPath(for: cell)
            destinationVC.selectedMovie = trendingMoviesModel?.results?[indexPath!.row].id
        }
    }
    
    //MARK: - Functions
        
    func getUpcomingMovies (url: String) {
        WebServices().get(url) {(type, model:MoviesModel?) in
            switch type {
            case .Succeed :
                self.trendingMoviesModel = model
                DispatchQueue.main.async {
                    self.trendingMoviesColVi.reloadData()
                }
            case .Failed : print("Error Failed")
            case .FailedDecode : print("Error FailedDecode")
            default : break
            }
        }
    }
    
    func getNowPlayingMovies (url: String) {
        WebServices().get(url, {(type, model:MoviesModel?) in
            switch type {
            case .Succeed :
                self.nowPlayingModel = model
                DispatchQueue.main.async {
                    self.nowPlayingColVi.reloadData()
                }
            case .Failed : print("Error Failed")
            case .FailedDecode : print("Error FailedDecode")
            default : break
            }
        })
    }
}
    //MARK: - UICollectionView Extension

extension StartPageController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //Sorun: collection view-in estimate size-ı automatic olduğundan resmin çözünürlüğüne göre büyüyormuş.
            //storyboard tarafında, size inspector-un altında collection view estimate size <none> yapıldı.
            
            //burada ise cell boyutu ayarlandı
            if collectionView.isEqual(nowPlayingColVi) {
                //eğer ilk cell ise genişlik sayfanın genişliği olarak ayarlandı.
                //yükseklik ise storyboard tarafında tanımlanan cell yüksekliği setlendi.
                return CGSize(width: view.frame.width, height: nowPlayingColVi.frame.height)
            }
            else {
                //eğer ikinci cell ise genişlik yine sayfanın genişliği olarak ayarlandı.
                //yükseklik ise storyboard tarafında tanımlanan ikinci cell yüksekliği setlendi.
                return CGSize(width: view.frame.width, height: trendingMoviesColVi.frame.height)
            }
            //not: storyboard tarafında bu her iki cell in yükseklikleri birbirine bağlı ve 1:2 oradı olarak setlemişsin.
            //not: resim boyutlarını istediğin formatta setleyebilirsin aspectfit aspect fill vs..
            //not: resim ve label constraintleri de düzenlendi.
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        if collectionView == self.nowPlayingColVi {
            performSegue(withIdentifier: "showNowPlayingMovieDetail", sender: cell)
            // Gondereni cell olarak sectigimiz icin burada da sender kismina cell yazmamiz lazim ancak oncesinde cell'in tanimini yapmamiz gerektigi icin yukarida bulunan guard let kismini yazmamiz gerekti. Daha sonra da perform segue kismini hazirlamamiz gerekti.
        } else {
            performSegue(withIdentifier: "showTrendingMovieDetail", sender: cell)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.nowPlayingColVi {
            let nowPlayingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
            if let imageUrl = self.nowPlayingModel?.results?[indexPath.row].poster_path{
            nowPlayingCell.nowPlayingImageView.setImageWithKF("\(URLs().baseImageURL)\(imageUrl)")
            }
            nowPlayingCell.nowPlayingImageView.layer.cornerRadius = 10
            nowPlayingCell.nowPlayingNameLabel.text = self.nowPlayingModel?.results?[indexPath.row].title
            
            return nowPlayingCell
        } else {
            let trendingMoviesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMoviesCell", for: indexPath) as! TrendingMoviesCell
            if let imageUrl = self.trendingMoviesModel?.results?[indexPath.row].poster_path{
                trendingMoviesCell.trendingMoviesImageView.setImageWithKF("\(URLs().baseImageURL)\(imageUrl)")
            }
            trendingMoviesCell.trendingMoviesImageView.layer.cornerRadius = 10
            trendingMoviesCell.trendingMoviesNameLabel.text = self.trendingMoviesModel?.results?[indexPath.row].title
            
            return trendingMoviesCell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.nowPlayingColVi {
            if self.nowPlayingModel != nil {
                return self.nowPlayingModel?.results?.count ?? 0
            } else {
                return 0
            }
        } else {
            if self.trendingMoviesModel != nil {
                return self.trendingMoviesModel?.results?.count ?? 0
            } else {
                return 0
            }
        }
        
    }
    
}
