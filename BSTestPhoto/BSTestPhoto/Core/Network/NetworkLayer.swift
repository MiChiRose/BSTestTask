//
//  NetworkLayer.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 9/1/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NetworkLayer

final class NetworkLayer {
    
    // MARK: - Public properties
    
    static func jsonDataTaskGet(page: Int, complition: @escaping (_ viewImageModel: [ImagePropertiesInCell]) -> ()) {
        guard let url = URL (string: "https://junior.balinasoft.com//api/v2/photo/type?page=\(page)") else {return}
        URLSession.shared.dataTask(with: url) {(data, responce, error) in
            guard let _ = responce, let data = data else { return }
            //print (responce)
            do {
                let imageType = try JSONDecoder().decode(ContentShow.self, from: data)
                //print(imageType)
                let viewImageModel = imageType.content.compactMap(ImagePropertiesInCell.init)
                complition(viewImageModel)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func jsonDataTaskPost(id: Int, image: UIImage){
        guard let url = URL(string: UrlApi.juniorBalinasoft) else {return}
        var request = URLRequest(url: url)
        let data = ImageProperties(withImage: image, forKey: "photo")
        let semaphore = DispatchSemaphore (value: 0)
        var body: String = ""
        
        let parameters = [
            [
                "key": "photo",
                "src": "",
                "type": "file"
            ],
            [
                "key": "name",
                "value": "Yura Menschikov",
                "type": "text"
            ],
            [
                "key": "typeId",
                "value": "\(id)",
                "type": "text"
            ]] as [[String : Any]]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    let fileContent = data?.data
                    body += "; filename=\"\(paramSrc)\"\r\n"
                        + "Content-Type: \"content-type header\"\r\n\r\n\(String(describing: fileContent))\r\n"
                }
            }
        }
        body += "--\(boundary)--\r\n";
        
        let postData = body.data(using: .utf8)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let finalTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        finalTask.resume()
        semaphore.wait()
    }
    
}
