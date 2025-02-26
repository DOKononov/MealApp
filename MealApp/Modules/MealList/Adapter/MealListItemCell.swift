//
//  MealListItemCell.swift
//  MealApp
//
//  Created by Dmitry Kononov on 24.02.25.
//

import UIKit
import SnapKit

final class MealListItemCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
//    private lazy var starButton: UIButton = {
//       let button = UIButton()
//        
//        return button
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with meal: Meal) {
        titleLabel.text = meal.name
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        selectionStyle = .none
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
