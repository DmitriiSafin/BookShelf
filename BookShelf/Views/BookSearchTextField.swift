//
//  BookSearchTextField.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import UIKit

protocol BookSearchTextFieldDelegate: AnyObject {
    func didTapCrossButton()
}

final class BookSearchTextField: UITextField {
    
    weak var searchFieldDelegate: BookSearchTextFieldDelegate?
    
    // MARK: - Views
    private let crossButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cross")?
            .withTintColor(.label), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return button
    }()
    
    private let searchImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "search")?
            .withTintColor(.secondaryLabel))
        view.heightAnchor.constraint(equalToConstant: 16).isActive = true
        view.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return view
    }()
    
    //MARK: - Private Property
    private let padding = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 75)
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Behavior
    private func setTargets() {
        crossButton.addTarget(self, action: #selector(didTapCrossButton), for: .touchUpInside)
    }
    
    @objc private func didTapCrossButton() {
        searchFieldDelegate?.didTapCrossButton()
    }
    
    //MARK: - Override Methodes
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - Setup TextField
    private func setupTextField() {
        autocorrectionType = .no
        attributedPlaceholder = NSAttributedString(
            string: "Search book", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ])
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
        backgroundColor = .clear
        
        let views = [crossButton, searchImageView]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            crossButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -18
            ),
            crossButton.centerYAnchor.constraint(
                equalTo: self.centerYAnchor
            ),
            
            searchImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 18
            ),
            searchImageView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor
            )
        ])
    }
}
