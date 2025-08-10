//
//  Query.swift
//  OnlineShop
//
//  Created by Anastasia N. on 27.07.2025.
//

import Foundation
import Combine
import FirebaseFirestore

struct FBListenerResult<T: Decodable>{
    
    let publisher: AnyPublisher<[T], Error>
    let listener: ListenerRegistration
    
}

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        let snapshot = try await getDocuments()
        return try snapshot.documents.map({try $0.data(as: T.self)})
    }
    
    func addSnapshotListener<T>(as type: T.Type) -> FBListenerResult<T> where T: Decodable {
        let publisher = PassthroughSubject<[T], Error>()
        let listener = addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                return
            }
            let items: [T] = documents.compactMap({ try? $0.data(as: T.self)})
            publisher.send(items)
        }
        return .init(publisher: publisher.eraseToAnyPublisher(), listener: listener)
    }
    
}

extension DocumentReference {
    
    func addSnapshotListener<T>(as type: T.Type) -> (AnyPublisher<T?, Error>, ListenerRegistration) where T: Decodable {
        let publisher = PassthroughSubject<T?, Error>()
        let listener = addSnapshotListener { querySnapshot, error in
            let item = try? querySnapshot?.data(as: T.self)
            publisher.send(item)
        }
        return (publisher.eraseToAnyPublisher(), listener)
    }
    
}
