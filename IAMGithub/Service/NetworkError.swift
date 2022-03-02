//
//  NetworkError.swift
//  IAMGithub
//
//  Created by 강호성 on 2022/03/01.
//

import Foundation

enum NetworkError: Error {
    case internet
    case noResult
    case noUser
    case redirection
    case server
    case unknown
    case login
    case invalidRequest
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .internet:
            return "인터넷 연결을 확인해주세요"
        case .noResult:
            return "검색 결과를 찾을 수 없습니다"
        case .noUser:
            return "사용자 정보 불러오기를 실패했습니다"
        case .redirection:
            return "리다이렉션으로 추가 후속 조치가 필요합니다"
        case .server:
            return "서버 상태가 불안정합니다"
        case .unknown:
            return "알 수 없는 문제가 발생했습니다"
        case .login:
            return "login이 필요합니다"
        case .invalidRequest:
            return "Request 형식이 맞지 않습니다"
        }
    }
}
