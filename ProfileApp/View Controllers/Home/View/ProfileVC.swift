//
//  ProfileVC.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileVC: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numPostsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    var profile = PublishSubject<Profile>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
    }
    
    private func setupBinding(){
        profile.asObservable()
            .subscribe(onNext: { [weak self] (profile) in
                guard let self = self else { return }
                self.userImageView.loadImage(fromURL: "\(APIManager.fileBaseUrl)\(profile.avatar)")
            })
            .disposed(by: disposeBag)
        
        profile.map({ $0.fullName })
            .bind(to: usernameLabel.rx.text)
            .disposed(by: disposeBag)
        
        profile.map({ "\($0.postsCount)" })
            .bind(to: numPostsLabel.rx.text)
            .disposed(by: disposeBag)
        
        profile.map({ "\($0.followingsCount)" })
            .bind(to: numFollowingLabel.rx.text)
            .disposed(by: disposeBag)
        
        profile.map({ "\($0.followersCount)" })
            .bind(to: numFollowersLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
