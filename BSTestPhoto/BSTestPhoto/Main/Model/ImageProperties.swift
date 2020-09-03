//
//  ImageProperties.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 9/2/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: - ImageProperties

import Foundation
import UIKit

struct ImageProperties {
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
    
}
