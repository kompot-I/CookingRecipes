//
//  ViewController.swift
//  CookingRecipes
//
//  Created by Nikita Zubov on 10.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let listOfRecipes: [RecipeCard] = []
    
    let tableView = UITableView()
    var sectionName = "Popular Recipes"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurerAppearanceScreen()
        setupTableView()
        setLayout()
    }


}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PopularCell.self), for: indexPath) as! PopularCell
        
        //cell.delegate = self
        
        if !listOfRecipes.isEmpty {
            let text = listOfRecipes[indexPath.row].title
            let imageName = listOfRecipes[indexPath.row].image
            cell.configureCell(title: text, image: imageName)
        } else {
            print("Не удалось сконфигурировать ячейку")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRecipes.count
    }
}

//MARK: - Setup TableView, Layout, configure appearance screen
private extension MainViewController {
    func configurerAppearanceScreen() {
        title = sectionName
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PopularCell.self, forCellReuseIdentifier: String(describing: PopularCell.self))
        tableView.dataSource = self
        //tableView.delegate = self
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
