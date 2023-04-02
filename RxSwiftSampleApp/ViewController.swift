//
//  ViewController.swift
//  RxSwiftSampleApp
//
//  Created by 滝野翔平 on 2023/04/02.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.label.text = "押されたぁぁぁ"
        })
        .disposed(by: disposeBag)
        
        Observable
            .combineLatest(textField1.rx.text.orEmpty,
                           textField2.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text1, text2 in
                guard let strongSelf = self else { return }
                strongSelf.button.isHidden = !strongSelf.isValid(text1: text1, text2: text2)
            })
            .disposed(by: disposeBag)
    }
    
    private func isValid(text1: String, text2: String) -> Bool {
        text1.count > 2 &&  text2.count > 2 && text1 == text2
    }
}

