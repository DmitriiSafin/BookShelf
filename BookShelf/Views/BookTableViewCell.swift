//
//  BookTableViewCell.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    
    //MARK: - Views
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 12
        return label
    }()
    
    private let dateOfPublicationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methodes
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        bookNameLabel.text = nil
        dateOfPublicationLabel.text = nil
    }
    
    func configure(with model: BookModel) {
        if let image = model.image {
            let urlString = "https://covers.openlibrary.org/b/OLID/\(image)-M.jpg"
            bookImageView.sd_setImage(with: URL(string: urlString))
        } else {
            bookImageView.image = UIImage(named: "book")
        }
        
        bookNameLabel.text = model.title
        if let date = model.firstPublishYear {
            dateOfPublicationLabel.text = "Date of first publication:\n\(date) year"
        } else {
            dateOfPublicationLabel.text = "unknown date"
        }
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        let views = [bookImageView, bookNameLabel, dateOfPublicationLabel]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            bookImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            bookImageView.widthAnchor.constraint(equalToConstant: 100),
            bookImageView.heightAnchor.constraint(equalToConstant: 150),
            
            bookNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            bookNameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 18),
            bookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            dateOfPublicationLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 18),
            dateOfPublicationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
