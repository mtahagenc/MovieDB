//
//  UIExtensions.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 14.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    @objc func setImageWithKF(_ url : String?) {
//        self.image = UIImage()
        if let imageUrl = url {
            if let urls = URL(string : imageUrl) {
                if imageUrl != "" {
                    let resource = ImageResource(downloadURL: urls, cacheKey: imageUrl)
                    DispatchQueue.main.async {
                        self.kf.setImage(with: resource ,options:[.loadDiskFileSynchronously,.transition(ImageTransition.fade(0.5))])
                        //                    self.kf.cancelDownloadTask()
                    }
                } else {
                    self.image = UIImage()
                }
            } else {
                self.image = UIImage()
            }
        } else {
            self.image = UIImage()
        }
    }
}
