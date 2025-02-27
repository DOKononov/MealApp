//
//  MealListItemCell.swift
//  MealApp
//
//  Created by Dmitry Kononov on 24.02.25.
//

import UIKit
import SnapKit
import Combine

final class MealListItemCell: UITableViewCell {
    private var bag: Set<AnyCancellable> = []
    @Passthrough
    var didAddToFavourite: AnyPublisher<Meal, Never>
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var starButton: UIButton = {
       let button = UIButton()
        button.setImage(.init(systemName: "star"), for: .normal)
        button.setImage(.init(systemName: "star.fill"), for: .selected)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: Meal) {
        titleLabel.text = model.name
        bind(for: model)
    }
    
    private func bind(for model: Meal) {
        starButton
            .tap()
            .map { [starButton] in !starButton.isSelected }
            .assign(to: \.isSelected, on: starButton)
            .store(in: &bag)
        
        starButton.tap()
            .map{ [model] in model }
            .subscribe(_didAddToFavourite.combine)
            .store(in: &bag)
    }
    
    func bind(to publisher: PassthroughSubject<Meal, Never>) {
        didAddToFavourite
            .subscribe(publisher)
            .store(in: &bag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = []
        starButton.isSelected = false
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(starButton)
        selectionStyle = .none
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(starButton.snp.leading).offset(-8)
        }
        
        starButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
    }
}
