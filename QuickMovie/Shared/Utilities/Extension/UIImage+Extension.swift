//
//  UIImage+Extension.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import UIKit

extension UIImageView {
    
    //MARK: Download and load image 
   func loadImage(fromURL url: String) {
      guard let imageURL = URL(string: url) else {
         print("Invalid URL")
         return
      }
      
      let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
         guard let self = self else {
            return
         }
         
         if let error = error {
            // Handle the error
            print("Error downloading image: \(error.localizedDescription)")
            return
         }
         
         guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
            // Handle the invalid HTTP response
            print("Invalid HTTP response")
            return
         }
         
         if let data = data,
            let image = UIImage(data: data) {
            DispatchQueue.main.async {
               self.image = image
            }
         }
      }
      task.resume()
   }
}

