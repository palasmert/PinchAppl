//
//  InfoPanelView.swift
//  Pinchapp
//
//  Created by mert palas on 19.02.2024.
//

import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisiable:  Bool = false
    
    var body: some View {
        HStack{
            //MARK: - HOTSPOT
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisiable.toggle()
                    }
                }
            
            Spacer()
            //MARK: - INFO PANEL
            HStack(spacing: 20){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")

                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(18)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisiable ? 1 : 0)
            Spacer()
        }
    }
}
#Preview {
    InfoPanelView(scale: 1, offset: .zero)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
