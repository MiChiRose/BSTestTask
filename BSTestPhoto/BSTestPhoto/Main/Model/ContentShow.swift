//
//  ContentShow.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 9/1/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: - ContentShow

struct ContentShow: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalElements: Int
    let content: [PhotoContent]
}

struct PhotoContent: Codable {
    let id: Int
    let name: String
}
