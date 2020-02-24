//
//  WebServices.swift
//  MovieDB
//
//  Created by Muhammet Taha Genc on 14.10.2019.
//  Copyright © 2019 Muhammet Taha Genc. All rights reserved.
//

import Foundation
import Alamofire

public class WebServices {
    public func get<T:Decodable> (_ url : String,_ completion : @escaping(Int,T?) -> Void) {
        Alamofire.request(url, method: .get).responseJSON {(response) in
            if response.result.isSuccess {
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data!)
                    // return the decodedModel
                    completion(.Succeed,model)
                } catch {
                    completion(.FailedDecode,nil)
                    print(error)
                    //print(String(data: data!, encoding: String.Encoding.utf8)!)
                }
            } else {
                print(response.result.error!)
                completion(.Failed, nil)
            }
        }
    }
    
    public func got<A:Decodable> (_ url: String, _ completion : @escaping(Int,A?) -> Void) {
        
    }
    
}


