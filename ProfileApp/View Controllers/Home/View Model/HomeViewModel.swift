//
//  HomeViewModel.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let profile  : PublishSubject<Profile> = PublishSubject()
    public let posts  : PublishSubject<[Post]> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let navTitle : PublishSubject<String> = PublishSubject()
    public let error   : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    public func requestProfileData() {
        self.loading.onNext(true)
        APIManager.requestProfile(url: "User/Profile/alimohammadian", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                self.profile.onNext(returnJson.result)
                self.navTitle.onNext(returnJson.result.username)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError:
                    self.error.onNext(.serverMessage("errorJson"))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
    
    public func requestPostsData() {
        self.loading.onNext(true)
        APIManager.requestPosts(url: "User/Discussions/alimohammadian", method: .get, parameters: nil, completion: { (result) in
            self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                self.posts.onNext(returnJson.result)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError:
                    self.error.onNext(.serverMessage("errorJson"))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
}
