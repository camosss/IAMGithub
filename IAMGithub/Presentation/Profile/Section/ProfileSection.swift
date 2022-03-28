//
//  ProfileSection.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/29.
//

import RxDataSources

typealias RepoItems = [UserReposResponse]

struct ProfileSection {

    typealias ProfileSectionModel = SectionModel<Int, RepoItems>

    enum RepoItems: Equatable {
        case firstItem(UserReposResponse)
    }
}
