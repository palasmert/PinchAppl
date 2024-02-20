//
//  PageModel.swift
//  Pinchapp
//
//  Created by mert palas on 19.02.2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
