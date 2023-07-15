//
//  DIContainer.swift
//  CarrotClone
//
//  Created by 강현준 on 2023/07/05.
//

import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()
    let container = Container()
    private init() {}
    
    func inject(){
        registerServices()
        registerDataSources()
        registerRepositories()
        registerUseCases()
        registerViewModels()
    }
    
    private func registerServices() {
        
    }
    
    private func registerDataSources() {
        
    }
    
    private func registerRepositories() {
        
    }
    
    private func registerUseCases() {
        
    }
    
    private func registerViewModels() {
        container.register(LoginMainViewModel.self) { _ in
            let viewModel = LoginMainViewModel()
            return viewModel
        }
        
        container.register(SignupPhoneNumberViewModel.self) { _ in
            let viewModel = SignupPhoneNumberViewModel()
            return viewModel
        }
    }
}
