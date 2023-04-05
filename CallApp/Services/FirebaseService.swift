//
//  FirebaseService.swift
//  CallApp
//
//  Created by devsalih on 4.04.2023.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    // MARK: - Auth
    
    func getCurrentUser() -> User? { auth.currentUser }
    
    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let result = result { completion(.success(result)) }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let result = result { completion(.success(result)) }
        }
    }
    
    func logout() throws { try auth.signOut() }
    
    func addAuthListener(completion: @escaping (Result<User?, Error>) -> Void) -> AuthStateDidChangeListenerHandle {
        return auth.addStateDidChangeListener { (auth, user) in
            if let user = user {
                auth.fetchSignInMethods(forEmail: user.email!) { (signInMethods, error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    if let signInMethods = signInMethods {
                        if signInMethods.contains("password") {
                            completion(.success(Auth.auth().currentUser))
                        }
                    }
                }
            } else { completion(.success(nil)) }
        }
    }
    
    // MARK: - Firestore
    
    func addDocument(collection: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collection).addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func addDocument(collection: String, documentId: String, data: [String: Any]) {
        db.collection(collection).document(documentId).setData(data)
    }
    
    func getDocuments(collection: String, completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void) {
        db.collection(collection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let snapshot = snapshot { completion(.success(snapshot.documents)) }
        }
    }
    
    func deleteDocument(collection: String, documentId: String) {
        db.collection(collection).document(documentId).delete()
    }
    
    func deleteHistory() {
        getDocuments(collection: "CallApp") { result in
            switch result {
            case .success(let documents):
                for document in documents { document.reference.delete() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addListener(collection: String, completion: @escaping (Result<QuerySnapshot, Error>) -> Void) -> ListenerRegistration {
        return db.collection(collection).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let snapshot = snapshot { completion(.success(snapshot)) }
        }
    }
    
    func removeListener(listener: ListenerRegistration?) { listener?.remove() }
}
