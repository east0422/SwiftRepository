//
//  GitHubRepositoryTest.swift
//  SingleViewTests
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import XCTest

class GitHubRepositoryTest: XCTestCase {
    
    func testRepository() {
        let repo = GitHubRepository()
        repo.id = 11
        repo.name = "mockname"
        XCTAssertEqual(repo.detailURL(), "https://api.github.com/resositories/11", "repository details")
    }
    
}
