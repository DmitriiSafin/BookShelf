//
//  BookTableViewCell.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import UIKit

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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 12
        return label
    }()
    
    private let dateOfPublicationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    //MARK: - Properties
    let identifier = "BookTableViewCell"
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        bookNameLabel.text = nil
        dateOfPublicationLabel.text = nil
    }
    
    func configure() {
        
    }
    
}
