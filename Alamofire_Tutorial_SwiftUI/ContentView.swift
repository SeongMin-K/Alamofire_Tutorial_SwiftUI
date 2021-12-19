//
//  ContentView.swift
//  Alamofire_Tutorial_SwiftUI
//
//  Created by SeongMinK on 2021/12/18.
//

import SwiftUI
import UIKit
import Introspect

class RefreshControlHelper {
    var parentContentView: ContentView?
    var refreshControl: UIRefreshControl?
    
    @objc func didRefresh() {
        print(#fileID, #function, "called")
        guard let parentContentView = parentContentView,
              let refreshControl = refreshControl else {
            print("parentContentView, refreshControl가 nil 입니다")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
            print("Refreshed!")
//            parentContentView.randomUserViewModel.fetchRandomUsers()
            parentContentView.randomUserViewModel.refreshActionSubject.send()
            refreshControl.endRefreshing()
        })
    }
}

struct ContentView: View {
    @ObservedObject var randomUserViewModel = RandomUserViewModel()
    let refreshControlHelper = RefreshControlHelper()
    
    var body: some View {
        List(randomUserViewModel.randomUsers) { randomUser in
            RandomUserRowView(randomUser)
        }
        .listStyle(.inset)
        .introspectTableView { self.configureRefreshControl($0) }
    }
}

extension ContentView {
    fileprivate func configureRefreshControl(_ tableView: UITableView) {
        print(#fileID, #function, "called")
        let myRefresh = UIRefreshControl()
        myRefresh.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        refreshControlHelper.refreshControl = myRefresh
        refreshControlHelper.parentContentView = self
        myRefresh.addTarget(refreshControlHelper, action: #selector(RefreshControlHelper.didRefresh), for: .valueChanged)
        tableView.refreshControl = myRefresh
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
