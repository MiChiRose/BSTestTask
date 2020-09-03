//
//  ImagePropertiesInCell.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 9/2/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: - ImagePropertiesInCell

struct ImagePropertiesInCell {
      let id: Int
      let name: String
}

extension ImagePropertiesInCell {
    init?(content: PhotoContent) {
        self.id = content.id
        self.name = content.name
    }
}
