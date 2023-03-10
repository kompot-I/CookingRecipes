//
//  CategoryCell.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    private let offset: CGFloat = 20
    private let radius: CGFloat = 20
    
    let containerForlabel = UIView()
    let titleLabel = UILabel()
    let foodImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyleCell()
        setupFoodImageView()
        setupTitle()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("oh no")
    }
}


//MARK: - Public Methods
extension CategoryCell {
    /// set title and image for imageView
    func configureCell(title text: String, and imageName: String) {
        titleLabel.text = text
        foodImageView.image = UIImage(named: imageName)
    }
}


//MARK: - Private Methods
private extension CategoryCell {
    func selectionStyleCell() {
        selectionStyle = .none
    }
    
    func setupTitle() {
        containerForlabel.backgroundColor = .white.withAlphaComponent(0.5)
        containerForlabel.translatesAutoresizingMaskIntoConstraints = false
        containerForlabel.layer.cornerRadius = radius
        contentView.addSubview(containerForlabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(named: "darkGray")
        titleLabel.font = UIFont(name: "Impact", size: 50)
        titleLabel.textAlignment = .center
        titleLabel.text = "CateroryCell"

        containerForlabel.addSubview(titleLabel)
    }

    func setupFoodImageView() {
        let foodImage = UIImage(named: "dessert")
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.contentMode = .scaleToFill
        foodImageView.image = foodImage
        foodImageView.layer.cornerRadius = radius
        foodImageView.clipsToBounds = true
        contentView.addSubview(foodImageView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset / 2),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset / 2),
            
            containerForlabel.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: offset),
            containerForlabel.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: offset),
            containerForlabel.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -offset),
            containerForlabel.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: -offset),

            titleLabel.heightAnchor.constraint(equalTo: containerForlabel.heightAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerForlabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerForlabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerForlabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerForlabel.bottomAnchor)
        ])
    }
}
