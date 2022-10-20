//
//  ListDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import Presentation
import UIKit
import Domain
import Repository

final class ListDIContainer {
    
    // MARK: Repository
    func makeCoinRepository() -> CoinRepositoryProtocol {
        return CoinRepository()
    }

    // MARK: UseCase
    func makeFetchCoinListUseCase() -> FetchCoinListUseCase {
        return DefaultFetchCoinListUseCase(coinRepository: makeCoinRepository())
    }
    
    // MARK: ViewModel
    func makeListViewModel() -> ListViewModel {
        return ListViewModel(fetchCoinListUseCase: makeFetchCoinListUseCase())
    }
    
    // MARK: Coordinator
    func makeListCoordinator(navigationController: UINavigationController)-> ListCoordinator {
        return ListCoordinator(navigationController:navigationController, dependencies: self)
    }
}

extension ListDIContainer: ListCoordinatorDependencies {
    func makeListViewController() -> ListViewController {
        return ListViewController.create(viewModel: makeListViewModel())
    }
}
