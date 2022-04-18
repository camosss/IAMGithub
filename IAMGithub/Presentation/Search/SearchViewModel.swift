//
//  SearchViewModel.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/16.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchViewModel {

    var repos = BehaviorRelay<[Repository]>(value: [])

    private let searchRepoAPI: SearchRepoAPIProtocol
    private let disposeBag = DisposeBag()

    init(searchRepoAPI: SearchRepoAPIProtocol = SearchRepoAPI()) {
        self.searchRepoAPI = searchRepoAPI
    }

    func populateSearchRepoData(with q: String, page: Int) {
        searchRepoAPI.populateSearchRepoData(with: q, page: page)
            .subscribe(onNext: { repos in
                if let repos = repos {
                    self.repos.accept(repos.items)
                }
            })
            .disposed(by: disposeBag)
    }
}
