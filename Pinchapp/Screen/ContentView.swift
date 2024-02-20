//
//  ContentView.swift
//  Pinchapp
//
//  Created by mert palas on 9.02.2024.
//

import SwiftUI

struct ContentView: View {
        //MARK: - PROP
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
     
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
        //MARK: - FUNC
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    
        //MARK: CONTENT
        
        var body: some View {
            NavigationView{
                ZStack{
                    Color.clear
                    
                    //MARK: PAGE IMAGE
                         Image(currentPage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                        .shadow(color: .black.opacity(0.2), radius: 12, x: 12, y:2)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: imageOffset.width, y: imageOffset.height)
                        .scaleEffect(imageScale)
                    //MARK: -1. TOP GESTURE
                        .onTapGesture(count: 2, perform: {
                            if imageScale == 1 {
                                withAnimation(.spring()) {
                                    imageScale = 5
                                }
                            } else {
                              resetImageState()
                            }
                        } )
                    //MARK: - 2.DRAG GEST
                    
                        .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        )
                    //MARK: - MAGNIFCAITON
                        .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5{
                                        imageScale  = 5
                                    }
                                }
                                
                            }
                            .onEnded { _ in
                                if imageScale > 5{
                                    imageScale = 5
                                    
                                } else if  imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        )
                }//: ZSTACK
                .navigationTitle("Pinch & Zoom")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: {
                    withAnimation(.linear(duration: 2)) {
                        isAnimating = true
                    }
                    })
                //MARK: - INFO PANEL
                .overlay (
                    InfoPanelView(scale: imageScale, offset: imageOffset)
                        .padding(.horizontal)
                        .padding(.top, 30)
                        ,alignment: .top
                )
                //MARK: CONTROLS
                .overlay(
                    Group {
                        HStack {
                            //SCALE DOWN
                            Button {
                                withAnimation(.spring()) {
                                    if imageScale > 1 {
                                        imageScale -= 1
                                        
                                        if imageScale <= 1 {
                                            resetImageState()
                                        }
                                    }
                                }

                                
                            } label : {
                                ControlimageView(icon: "minus.magnifyingglass")
                            }
                            //SCALE RESET
                            Button {
                                resetImageState()
                            } label : {
                                ControlimageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                            }
                            
                            // SCALE UP
                            Button {
                                withAnimation(.spring()) {
                                    if imageScale < 5 {
                                        imageScale += 1
                                        
                                        if imageScale > 5{
                                            imageScale =  5
                                        }
                                    }
                                }

                            } label : {
                                ControlimageView(icon: "plus.magnifyingglass")
                            }
                            
                            
                            
                        }//: CONTROLS
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 12, trailing: 20))
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .opacity(isAnimating ? 1 : 0)
                            
                        }
                        .padding(.bottom, 30)
                        , alignment: .bottom
                )
        //MARK: DRAWER
                .overlay(
                    HStack(spacing: 12){
                        //MARK: -DRAWER HANDLE
                        Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(8)
                            .foregroundStyle(.secondary)
                            .onTapGesture(perform: {
                                withAnimation(.easeOut) {
                                    isDrawerOpen.toggle()
                                }
                            })
                    
                        //MARK: -THUMBNAILS
                        ForEach(pages) { item in
                            Image(item.thumbnailName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                                .opacity(isDrawerOpen ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                                .onTapGesture(perform: {
                                isAnimating = true
                                pageIndex = item.id
                                })
                            
                        }
                        
              
                        Spacer()
                        
                    } //: DRAWER
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 16))
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .opacity(isAnimating ? 1 : 0)
                        .padding(.top, UIScreen.main.bounds.height / 40)
                        .offset(x: isDrawerOpen ? 50 : 348)
                    ,alignment: .topTrailing
                )
                    
                }//: NAVIGATION
            .navigationViewStyle(.stack)

         }
}
//MARK: - PREV
struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
            .preferredColorScheme(.dark)
    }
}
