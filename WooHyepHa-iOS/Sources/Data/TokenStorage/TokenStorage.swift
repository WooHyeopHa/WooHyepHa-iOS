//
//  TokenStorage.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 11/5/24.
//

import Foundation
import Security

enum TokenStorageError: Error {
    case failedToSaveToken
    case failedToLoadToken
    case failedToDeleteToken
}

enum TokenType {
    case access
    case refresh
    
    var key: String {
        switch self {
        case .access:
            return "accessToken"
        case .refresh:
            return "refreshToken"
        }
    }
}

final class TokenStorage {
    static let shared = TokenStorage()
    
    private init() {}
    
    // 키체인에서 토큰을 저장하고 검색할 때 사용하는 고유 식별자
    // 보통 앱의 번들 ID를 사용한다.
    private let serviceIdentifier = Bundle.main.bundleIdentifier ?? "yeo.WooHyepHa-iOS"
    
    // kSecClass : 키체인 아이템 클래스 타입
    // kSecAttrService : 서비스 아이디 (앱 번들 아이디)
    // kSecAttrAccount : 저장할 아이템의 계정 이름
    // kSecAttrGeneric : 저장할 아이템의 데이터
    
    func saveToken(_ token: String, type: TokenType) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // kSecClassGenericPassword는 일반적인 비밀번호/토큰 저장에 사용한다.
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: type.key, // 실제 키체인 항목을 식별하는 고유 키, 같은 서비스 내에서 여러 항목을 구분한다.
            kSecValueData as String : token.data(using: .utf8, allowLossyConversion: false) as Any // 실제 저장할 데이터 값으로, 반드시 Data 타입으로 변환해야 한다.
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            try updateToken(token, type: type)
        } else if status != errSecSuccess {
            throw TokenStorageError.failedToSaveToken
        }
    }
    
    // kSecMatchLimit : 검색 결과의 최대 개수를 지정
    // kSecReturnData : 실제 저장된 데이터 반환 여부
    
    func loadToken(type: TokenType) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: type.key,
            kSecMatchLimit as String: kSecMatchLimitOne, // 첫 번째 일치하는 항목만 반환
            kSecReturnData as String: true // true로 설정하면 저장된 데이터를 반환
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result) // 일치하는 아이템이 있으면 result에 할당
        
        if status == errSecSuccess,
            let data = result as? Data,
            let token = String(data: data, encoding: .utf8) {
                return token
        } else if status == errSecItemNotFound {
            return nil
        }
        throw TokenStorageError.failedToLoadToken
    }
    
    func deleteToken(type: TokenType) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: type.key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            throw TokenStorageError.failedToDeleteToken
        }
    }
    
    func validateAuthentication() -> Bool {
        do {
            let hasAccessToken = try loadToken(type: .access) != nil
            let hasRefreshToken = try loadToken(type: .refresh) != nil
            return hasAccessToken && hasRefreshToken
        } catch {
            return false
        }
    }
    
    func deleteAllTokens() throws {
        try deleteToken(type: .access)
        try deleteToken(type: .refresh)
    }
}

private extension TokenStorage {
    func updateToken(_ token: String, type: TokenType) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecAttrAccount as String: type.key
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        if status != errSecSuccess {
            throw TokenStorageError.failedToSaveToken
        }
    }
}
