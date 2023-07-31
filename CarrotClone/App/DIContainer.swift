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
        container.register(AuthDataSourceProtocol.self) { _ in AuthDataSource() }
        container.register(KeychainProtocol.self) { _ in
            Keychain()
        }
        container.register(KeychainManagerProtocol.self) { resolver in
            var datasource = KeychainManager()
            datasource.keychain = resolver.resolve(KeychainProtocol.self)
            
            return datasource
        }
    }
    
    private func registerRepositories() {
        container.register(AuthRepositoryProtocol.self) { resolver in
            var repository = AuthRepository()
            repository.authDataSource = resolver.resolve(AuthDataSourceProtocol.self)
            
            return repository
        }
        
        container.register(TokenRepositoryProtocol.self) { resolver in
            var repository = TokenRepository()
            repository.keychainManager = resolver.resolve(KeychainManagerProtocol.self)
            
            return repository
        }
    }
    
    private func registerUseCases() {
        container.register(SignInUseCaseProtocol.self) { resolver in
            var useCase = SignInUseCase()
            useCase.authRepository = resolver.resolve(AuthRepositoryProtocol.self)
            useCase.tokenRepository = resolver.resolve(TokenRepositoryProtocol.self)
            
            return useCase
        }
    }
    
    private func registerViewModels() {
        container.register(LoginMainViewModel.self) { resolver in
            let viewModel = LoginMainViewModel()
            
            return viewModel
        }
        
        container.register(LoginViewModel.self) { resolver in
            let viewModel = LoginViewModel()
            
            return viewModel
        }
        
        container.register(SignupViewModel.self) { resolver in
            let viewModel = SignupViewModel()
            
            return viewModel
        }
        
        container.register(CertifyViewModel.self) { resolver in
            let viewModel = CertifyViewModel()
            viewModel.signinUseCase = resolver.resolve(SignInUseCaseProtocol.self)
            return viewModel
        }
    }
}
