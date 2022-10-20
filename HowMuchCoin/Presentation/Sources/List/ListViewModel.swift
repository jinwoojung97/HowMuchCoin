//
//  ListViewModel.swift
//  Presentation
//
//  Created by inforex on 2022/10/20.
//

import Foundation

import Domain
import Util

public final class ListViewModel {

    private var fetchCoinListUseCase : FetchCoinListUseCase

    public init(fetchCoinListUseCase: FetchCoinListUseCase){
        self.fetchCoinListUseCase = fetchCoinListUseCase
        
        fetchCoinList()
    }

    func fetchCoinList() {
        fetchCoinListUseCase.execute{ result in
            switch result {
            case .success(let list):
                Log.d(list)
            case .failure(let error):
                Log.e(error.localizedDescription)
            }
        }
    }
}
