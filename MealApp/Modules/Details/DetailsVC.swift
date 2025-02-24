//
//  DetailsVC.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit
import SnapKit
import Combine

protocol DetailsViewModelProtocol {
    var model: Meal { get }
    var imageDidLoad: AnyPublisher<UIImage?, Never> { get }
}

final class DetailsVC: UIViewController {
    
    private let viewModel: DetailsViewModelProtocol
    private var bag: Set<AnyCancellable> = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20.0)
        label.text = viewModel.model.name
        label.textColor = .darkText
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.text = viewModel.model.category
        label.textColor = .darkText
        return label
    }()
    
    private lazy var receiptLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0)
        label.text = viewModel.model.receipt
        label.textColor = .darkText
        label.numberOfLines = .zero
        return label
    }()
    
    init(viewModel: DetailsViewModelProtocol) {
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
        viewModel.imageDidLoad
            .assign(to: \.image, on: imageView)
            .store(in: &bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(receiptLabel)
        scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        scrollView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
        }
        
        receiptLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(categoryLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}




