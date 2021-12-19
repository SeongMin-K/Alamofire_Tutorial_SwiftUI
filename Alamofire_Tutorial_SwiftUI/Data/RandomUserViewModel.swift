//
//  RandomUserViewModel.swift
//  Alamofire_Tutorial_SwiftUI
//
//  Created by SeongMinK on 2021/12/18.
//

import Foundation
import Combine
import Alamofire

class RandomUserViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    @Published var randomUsers = [RandomUser]()
    var baseUrl = "https://randomuser.me/api/?results=100"
    var refreshActionSubject = PassthroughSubject<(), Never>()
    
    init() {
        print(#fileID, #function, "called")
        fetchRandomUsers()
        refreshActionSubject.sink { [weak self] _ in
            guard let self = self else { return }
            print("RandomUserViewModel - init - refreshActionSubject called")
            self.fetchRandomUsers()
        }.store(in: &subscription)
    }
    
    fileprivate func fetchRandomUsers() {
        print(#fileID, #function, "called")
        AF.request(baseUrl)
            .publishDecodable(type: RandomUserResponse.self)
            .compactMap { $0.value } // Unwrapping
            .map { $0.results }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { [weak self] (receivedValue: [RandomUser]) in
                guard let self = self else { return }
                print("받은 값: \(receivedValue.count)")
                self.randomUsers = receivedValue
            }).store(in: &subscription)
    }
}
