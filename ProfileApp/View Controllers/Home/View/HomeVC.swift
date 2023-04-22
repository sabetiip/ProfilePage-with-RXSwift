//
//  HomeVC.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {

    @IBOutlet weak var profileVCView: UIView!
    @IBOutlet weak var postsVCView: UIView!
    
    private lazy var profileVC: ProfileVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.add(asChildViewController: viewController, to: profileVCView)
        return viewController
    }()
    
    private lazy var postsVC: PostsVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
        self.add(asChildViewController: viewController, to: postsVCView)
        return viewController
    }()
    
    var homeViewModel = HomeViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        homeViewModel.requestProfileData()
        homeViewModel.requestPostsData()
    }
    
    private func setupBindings() {
        
        homeViewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        homeViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
        
        homeViewModel.navTitle
            .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        homeViewModel
            .profile
            .observe(on: MainScheduler.instance)
            .bind(to: profileVC.profile)
            .disposed(by: disposeBag)
        
        homeViewModel
            .posts
            .observe(on: MainScheduler.instance)
            .bind(to: postsVC.posts)
            .disposed(by: disposeBag)
       
    }
}
