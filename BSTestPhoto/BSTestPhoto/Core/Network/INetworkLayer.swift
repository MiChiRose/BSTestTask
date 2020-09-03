//
//  INetworkLayer.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 9/1/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: - INetworkLayer

import UIKit

protocol INetworkLayer {
    func jsonDataTaskGet(page: Int, complition: @escaping (_ viewImageModel: [ImageProperties]) -> ())
    func jsonDataTaskPost(id: Int, image: UIImage)
}
