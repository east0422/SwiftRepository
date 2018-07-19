//
//  GitHubRepository.swift
//  SingleView
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

class GitHubRepository: GitHubProtocol {
    let api = "https://api.github.com"
    
    var id = 0
    var name: String = ""
    
    func detailURL() -> String {
        return "\(api)/resositories/\(id)"
    }
}
