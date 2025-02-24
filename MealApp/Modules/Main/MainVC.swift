//
//  MainVC.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit
import SnapKit
import Combine

protocol MainViewModelProtocol {
    var randomDidTap: PassthroughSubject<Void, Never> { get }
    var listDidTap: PassthroughSubject<Void, Never> { get }
}

final class MainVC: UIViewController {
    
    private var bag: Set<AnyCancellable> = []
    
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Random meal", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.setTitleColor(.systemPurple.withAlphaComponent(0.7), for: .highlighted)
        
        return button
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("All meals", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.setTitleColor(.systemPurple.withAlphaComponent(0.7), for: .highlighted)
        
        return button
    }()
    
    private let viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
        randomButton.tap()
            .subscribe(viewModel.randomDidTap)
            .store(in: &bag)
        
        listButton.tap()
            .subscribe(viewModel.listDidTap)
            .store(in: &bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(randomButton)
        view.addSubview(listButton)
        
        randomButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        listButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(randomButton.snp.bottom).offset(16)
        }
    }
}




