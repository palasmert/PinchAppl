//
//  ControlimageView.swift
//  Pinchapp
//
//  Created by mert palas on 19.02.2024.
//

import SwiftUI

struct ControlimageView: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlimageView(icon: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
