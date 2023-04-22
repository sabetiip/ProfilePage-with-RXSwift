//
//  BaseResponse.swift
//  ProfileApp
//
//  Created by Somayeh Sabeti on 2/4/21.
//  Copyright © 2021 Somayeh Sabeti. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let result: T
    let serverTime: String
}
