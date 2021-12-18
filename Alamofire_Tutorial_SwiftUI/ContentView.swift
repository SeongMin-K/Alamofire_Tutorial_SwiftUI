//
//  ContentView.swift
//  Alamofire_Tutorial_SwiftUI
//
//  Created by SeongMinK on 2021/12/18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var randomUserViewModel = RandomUserViewModel()
    
    var body: some View {
        List(randomUserViewModel.randomUsers) { randomUser in
            RandomUserRowView(randomUser)
        }.listStyle(.inset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
