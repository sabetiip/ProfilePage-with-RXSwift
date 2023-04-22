//
//  PostCollectionViewCell.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gifView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public var post: Post! {
        didSet {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                let gifURL: String = "\(APIManager.fileBaseUrl)\(self.post.videoUrl).gif"
                let imageURL = UIImage.gifImageWithURL(gifURL)
                DispatchQueue.main.async {
                    let imageView3 = UIImageView(image: imageURL)
                    imageView3.frame = self.gifView.frame
                    self.gifView.addSubview(imageView3)
                }
            }
            titleLabel.text = post.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gifView.cornerRadius = 4
        gifView.clipsToBounds = true
    }
}
