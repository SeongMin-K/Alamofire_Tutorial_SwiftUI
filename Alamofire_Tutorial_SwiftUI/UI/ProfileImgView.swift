//
//  ProfileImgView.swift
//  Alamofire_Tutorial_SwiftUI
//
//  Created by SeongMinK on 2021/12/18.
//

import SwiftUI
import URLImage

struct ProfileImgView: View {
    var imageUrl: URL
    
    var body: some View {
        URLImage(imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 50, height: 60)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.yellow, lineWidth: 2))
    }
}

struct ProfileImgView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://randomuser.me/api/portraits/men/76.jpg")!
        
        ProfileImgView(imageUrl: url)
    }
}
