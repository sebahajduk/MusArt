//
//  ContentView.swift
//  MusArt
//
//  Created by Aneta on 21/06/2021.
//

import SwiftUI

extension Color {
    static let offwhite = Color(red: 0.9, green: 0.9, blue: 0.91)
}

extension String {
    func load() -> UIImage {
        
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        
        return UIImage()
    }
}

struct ContentView: View {
    
    @State var search: String = ""
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        
        NavigationView {
            ScrollView {
                ZStack {
                    Color.offwhite.edgesIgnoringSafeArea(.all).padding(.top, -150)
                    LazyVStack {
                        
                        ForEach(networkManager.art, id: \.objectID) { art in
                            ArtCell(artistName: art.artistDisplayName, artTitle: art.title, artImage: art.primaryImageSmall)
                                .onAppear(perform: {
                                    networkManager.loadArt()
                                    print("\(art.objectID)")
                                })
                        }
                        
                        
                        .background(Color.offwhite)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                    }.onAppear(perform: {
                        self.networkManager.loadData()
                    })
                        .navigationBarItems(leading:
                                                TextField("Search", text: $search),
                                            
                                            trailing:
                                                HStack {
                                                    Button(action: {
                                                        print("Heart tapped")
                                                        networkManager.loadArt()
                                                    }) {
                                                        Image(systemName: "heart.fill")
                                                            .foregroundColor(.gray)
                                                    }.buttonStyle(FavoriteButtonStyle())
                                                    
                                                }
                                            
                        )
                        
                    
                }
                
                
            }
            
            
        }
        
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct ArtCell: View {
        
        let artistName: String?
        let artTitle: String?
        let artImage: String?
        
        
        var body: some View {
            ZStack(alignment: .center){
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.offwhite)
                    .frame(width: 380, height: 300)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(1), radius: 5, x: -5, y: -5)
                
                VStack(alignment: .leading, spacing: 5) {
                    ZStack(alignment: .top) {
                        Image(systemName: "rectangle.slash")
                            .resizable()
                            .frame(width: 170, height: 120)
                            .foregroundColor(.gray)
                            .padding(.top, 70)
                        Image(uiImage: artImage!.load())
                            .resizable()
                            .cornerRadius(25)
                            .frame(width: 340, height: 240)
                        HStack() {
                            Spacer()
                            Button(action: {
                                print("Heart tapped")
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.gray)
                            }.buttonStyle(FavoriteButtonStyle())
                            Button(action: {
                                print("Heart tapped")
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.gray)
                                
                            }.buttonStyle(FavoriteButtonStyle())
                            
                            Button(action: {
                                print("Heart tapped")
                            }) {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                                
                            }.buttonStyle(FavoriteButtonStyle())
                        }.padding(10)
                        
                       
                    }
                    VStack(alignment: .leading) {
                            Text(artTitle ?? "Unknown")
                                .bold()
                                .foregroundColor(.gray)
                                .lineLimit(1)
                            Text(artistName ?? "Unknown")
                                .foregroundColor(.gray)
                                .opacity(0.7)
                                .lineLimit(1)
                                
                        }
                    }
                    .frame(width: 340, height: 310)
                
                
            }
        }
    }
    
    struct FavoriteButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: 30, height: 30, alignment: .center)
                .background(
                    Circle()
                        .foregroundColor(.offwhite)
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 3, y: 3)
                        .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
                )
        }
    }

