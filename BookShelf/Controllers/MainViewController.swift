//
//  MainViewController.swift
//  BookShelf
//
//  Created by Дмитрий on 18.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Views
    private let tableView = UITableView()
    private let searchTextField = BookSearchTextField()
    private let activityIndicator = UIActivityIndicatorView()
    
    //MARK: - Properties
    private let apiManager = ApiManager(
        networkManager: NetworkManager(jsonService: JSONDecoderManager()))
    private var books: [BookModel] = []
    
    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchTextField.delegate = self
        searchTextField.searchFieldDelegate = self
        setupTableView()
        setupUI()
        tapGesture()
    }
    
    //MARK: - Private Methodes
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    //MARK: - Network Methodes
    private func fetchSearchBooks(with title: String) {
        Task {
            do {
                books = try await apiManager.fetchBooks(title: title).docs
                await MainActor.run(body: {
                    activityIndicator.stopAnimating()
                    tableView.reloadData()
                })
            } catch {
                activityIndicator.stopAnimating()
                alertError(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

//MARK: - Book Search TextFieldDelegate
extension MainViewController: BookSearchTextFieldDelegate {
    func didTapCrossButton() {
        searchTextField.text = nil
        searchTextField.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var book = textField.text, book.count != 0 else { return true }
        book = book.lowercased().replacingOccurrences(of: " ", with: "+")
        activityIndicator.startAnimating()
        fetchSearchBooks(with: book)
        textField.text = ""
        textField.endEditing(true)
        return true
    }
}

//MARK: - SetupUI
extension MainViewController {
    
    private func setupUI() {
        let views = [searchTextField, tableView, activityIndicator]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: - AlertController
extension MainViewController {

    private func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
