//
//  CategoryRecipesViewController.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import UIKit

class CategoryRecipesViewController: UIViewController {
    
    private let cellHeight: CGFloat = 200
    
    let source: [RecipeCard] = getAllCategories()
    private var sectionName = "Category Recipes"
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(named: "blueColor")
        
        setupAppearance()
        setupTableView()
        setConstraints()
    }
}


extension CategoryRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
        let categoryType = cell.titleLabel.text!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

//MARK: - UITableViewDataSource
extension CategoryRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        //cell.contentView.backgroundColor = .clear
        let textTitle = source[indexPath.row].title.capitalized
        let imageName = source[indexPath.row].image
        
        cell.configureCell(title: textTitle, and: imageName)
        
        return cell
    }
}


//MARK: - Private Methods, setup
private extension CategoryRecipesViewController {
    func setupAppearance() {
        title = sectionName
        view.backgroundColor = UIColor(named: "blueColor")
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(CategoryCell.self, forCellReuseIdentifier: String(describing: CategoryCell.self))
        tableView.dataSource = self
        tableView.delegate = self 
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
