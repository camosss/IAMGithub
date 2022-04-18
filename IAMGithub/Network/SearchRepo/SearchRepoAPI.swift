//
//  SearchRepoAPI.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/04/18.
//

import RxSwift
import Moya

protocol SearchRepoAPIProtocol {
    func populateSearchRepoData(with q: String, page: Int) -> Observable<SearchRepoResponse?>
}

final class SearchRepoAPI: SearchRepoAPIProtocol {
    let service: MoyaProvider<SearchRepoTarget>
    init() { service = MoyaProvider<SearchRepoTarget>() }
}

extension SearchRepoAPI {

    func populateSearchRepoData(
        with q: String,
        page: Int
    ) -> Observable<SearchRepoResponse?> {
        return .create { observer in
            self.service
                .request(.populateSearchRepoData(q: q, page: page)) { result in
                    switch result {
                    case .success(let response):
                        let searchResponse = try? response.map(SearchRepoResponse.self)
                        observer.onNext(searchResponse)
                    case .failure(let error):
                        print("[populateSearchRepoData] error", error)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
