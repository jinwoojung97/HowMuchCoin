//
//  ListViewModel.swift
//  Presentation
//
//  Created by inforex on 2022/10/20.
//

import Foundation
import Domain
import Util

public class ListViewModel {

    private var fetchCoinListUseCase : FetchCoinListUseCase

    public init(fetchCoinListUseCase: FetchCoinListUseCase){
        self.fetchCoinListUseCase = fetchCoinListUseCase
    }

    func fetchCoinList() {
        fetchCoinListUseCase.execute{ list in
            Log.d(list)
        }
    }
}
