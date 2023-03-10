//
//  PopularCell.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import UIKit
import Kingfisher

protocol PopularCellDelegate {
    func didPressFavoriteButton(_ cell: PopularCell, button: UIButton)
}


class PopularCell: UITableViewCell {
    private let offset: CGFloat = 20
    private let heightCell: CGFloat = 200
    private let radius: CGFloat = 20
    
    var delegate: PopularCellDelegate?
    
    let titleLabel = UILabel()
    private let foodImageView = UIImageView()
    private let heartButton = UIButton(type: .system)
    private let containerForCell = UIView()
    private var gradientView = GradientView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        selectionStyleCell()
        setupImage()
        setupTitle()
        setupButton()
        setupContainerForCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        
        gradientView = GradientView(frame: titleLabel.bounds)
    }
    
    @objc func heartButtonPressed(_ sender: UIButton) {
        animateButton(sender, playing: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateButton(sender, playing: false)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        delegate?.didPressFavoriteButton(self, button: sender)
    }
    
    func configureCell(title: String, image: String) {
        titleLabel.text = title
        if !image.contains("https") {
            foodImageView.image = UIImage(named: "beverage")
        } else {
            foodImageView.kf.setImage(with: URL(string: image))
        }
    }
}


//MARK: - Configure Cell
private extension PopularCell {
    func selectionStyleCell() {
        selectionStyle = .none
    }
    
    
    func configureGradientView() {
        gradientView.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func setupContainerForCell() {
        containerForCell.layer.cornerRadius = offset
        containerForCell.layer.masksToBounds = true
        containerForCell.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupImage() {
        foodImageView.contentMode = .scaleToFill
        foodImageView.image = UIImage(named: "main course")
        foodImageView.layer.cornerRadius = radius
        foodImageView.clipsToBounds = true
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupButton() {
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.layer.cornerRadius = offset / 2
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.tintColor = .white
        heartButton.addTarget(self, action: #selector(heartButtonPressed), for: .touchUpInside)
    }
    
    
    func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "How to make yam & vegetable sauce at home"
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func animateButton(_ sender: UIButton, playing: Bool) {
        if playing {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.autoreverse, .repeat],
                           animations: { sender.alpha = 0.5 },
                           completion: nil)
        } else {
            UIView.animate(withDuration: 0.5,
                           animations: { sender.alpha = 1 },
                           completion: nil)
        }
    }
}


//MARK: - Layout Constraints
private extension PopularCell {
    func addSubview() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(containerForCell)
        containerForCell.addSubview(gradientView)
        containerForCell.addSubview(titleLabel)
        containerForCell.addSubview(heartButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset / 2),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: heightCell)
        ])
        
        NSLayoutConstraint.activate([
            containerForCell.topAnchor.constraint(equalTo: foodImageView.topAnchor),
            containerForCell.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor),
            containerForCell.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor),
            containerForCell.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: containerForCell.topAnchor, constant: offset/2),
            heartButton.trailingAnchor.constraint(equalTo: containerForCell.trailingAnchor, constant: -offset/2),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
            heartButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerForCell.topAnchor, constant: 160),
            titleLabel.leadingAnchor.constraint(equalTo: containerForCell.leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: containerForCell.trailingAnchor, constant: -offset),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: containerForCell.topAnchor, constant: 160),
            gradientView.leadingAnchor.constraint(equalTo: containerForCell.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: containerForCell.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: containerForCell.bottomAnchor)
        ])
    }
}
