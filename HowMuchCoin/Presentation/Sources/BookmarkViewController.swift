//
//  BookmarkViewController.swift
//  Presentation
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit
import RxSwift

public final class BookmarkViewController: UIViewController {
    var coordinator: BookmarkCoordinator?
    let disposeBag = DisposeBag()

    /// ViewController 의존성 주입을 위한 Create 함수
    public static func create()-> BookmarkViewController {
        let vc = BookmarkViewController()

        return vc
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
