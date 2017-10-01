//
//  Cache.swift
//  OutReach
//
//  Created by Louis-Philip Shahim on 2017/05/21.
//  Copyright © 2017 Louis-Philip Shahim. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImagePostsFromURL(urlString : String){
        
        
        
        DispatchQueue.main.async {
            if let cachedImage = imageCache.object(forKey: urlString as AnyObject ){
                self.image = cachedImage as? UIImage
                return
            }
        
        
        let myUrl = URL(string : urlString)
        
        URLSession.shared.dataTask(with: myUrl!, completionHandler: { (imageData, response, error) in
            
            if error != nil{
                print(error!)
                return
            }
            
            if let downloadedImage = UIImage(data: imageData!){
                
                imageCache.setObject(downloadedImage, forKey: urlString as AnyObject )
                self.image = downloadedImage
            }
            
        
        
            
        }).resume()
    }
}
}
