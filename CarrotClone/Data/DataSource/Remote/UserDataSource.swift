//
//  UserDataSource.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/06.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseStorage

struct UserDataSource: UserDataSourceProtocol {
    
    let fireStore = Firestore.firestore().collection("User")
    
    // 데이터를 읽어옴.
    func read(uid: String) -> Observable<UserResponseDTO> {
        return Observable.create { emitter in
            fireStore.document(uid).getDocument { snapshot, _ in
                if let data = snapshot?.data(),
                   let response = try? JSONSerialization.data(withJSONObject: data),
                   let decoded = try? JSONDecoder().decode(UserResponseDTO.self, from: response) {
                    
                    emitter.onNext(decoded)
                }
            }
            
            return Disposables.create()
        }
    }
    
    // 데이터가 존재하는지 확인
    func exitsUserData(uid: String) -> Observable<Bool> {
        return Observable.create { emitter in
            fireStore.document(uid).getDocument { snapshot, _ in
                if let snapshot {
                    emitter.onNext(snapshot.exists)
                } else {
                    emitter.onNext(false)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func edit(request: UserRequestDTO) -> Observable<UserResponseDTO> {
        return Observable.create { emitter in
            fireStore.document(request.uid).setData(request.toDictionary()) { error in
                if let error {
                    emitter.onError(error)
                } else {
                    emitter.onNext(request.toResponse())
                }
            }
            
            return Disposables.create()
        }
    }
    
    func uploadProfileImage(id: String, imageData: Data) -> Observable<URL> {
        return Observable.create { emitter in
            let ref = Storage.storage().reference().child("User").child(id).child("profileImageURL")
            
            ref.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                ref.downloadURL { url, error in
                    guard let url = url else {
                        if let error = error {
                            emitter.onError(error)
                        }
                        return
                    }
                    emitter.onNext(url)
                }
            }
            return Disposables.create()
        }
    }
}
