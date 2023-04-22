//
//  Profile.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import Foundation
import RxSwift

struct Profile: Codable {
    let fullName: String
    let username: String
    let avatar: String
    let postsCount: Int
    let followingsCount: Int
    let followersCount: Int
}
