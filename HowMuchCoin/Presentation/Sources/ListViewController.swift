//
//  ListViewController.swift
//  Presentation
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit
import RxSwift

public final class ListViewController: UIViewController {
    var coordinator: ListCoordinator?
    let disposeBag = DisposeBag()

    /// ViewController 의존성 주입을 위한 Create 함수
    public static func create()-> ListViewController {
        let vc = ListViewController()

        return vc
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
