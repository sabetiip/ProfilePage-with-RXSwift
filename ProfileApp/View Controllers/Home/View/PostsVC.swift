//
//  PostsVC.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = PublishSubject<[Post]>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (collectionView.frame.width - 8) / 3 , height: 200)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4.0
        flowLayout.minimumInteritemSpacing = 4.0
        flowLayout.sectionInset = .zero
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.backgroundColor = .clear
    }
    
    private func setupBinding() {
        collectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self))

        posts.bind(to: collectionView.rx.items(cellIdentifier: "PostCollectionViewCell", cellType: PostCollectionViewCell.self)) {  (row,post,cell) in
            cell.post = post
            }.disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }
}
