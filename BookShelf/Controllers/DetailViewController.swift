//
//  DetailViewController.swift
//  BookShelf
//
//  Created by Дмитрий on 19.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Views
    private let mainScrollView = UIScrollView()
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    private let storyLineLabel: UILabel = {
        let label = UILabel()
        label.text = "Story Line"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let textView: UILabel = {
        let text = UILabel()
        text.font = .systemFont(ofSize: 14)
        text.numberOfLines = 0
        return text
    }()
    
    private let dateOfPublicationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    //MARK: - Initializers
    init(imageBook: String?, nameBook: String?, rating: Double?, storyBook: String?, dateBook: Int?) {
        self.bookNameLabel.text = nameBook
        self.textView.text = storyBook
        super.init(nibName: nil, bundle: nil)
        getStarsImage(with: rating ?? 0)
        configure(date: dateBook, imageBook: imageBook)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methodes
    
    private func configure(date: Int?, imageBook: String?) {
        if let date = date {
            dateOfPublicationLabel.text = "Date of first publication:\n\(date) year"
        } else {
            dateOfPublicationLabel.text = "unknown date"
        }
        
        if let image = imageBook {
            let urlString = "https://covers.openlibrary.org/b/OLID/\(image)-L.jpg"
            bookImageView.sd_setImage(with: URL(string: urlString))
        } else {
            bookImageView.image = UIImage(named: "book")
        }
    }
    
    @objc private func didTapBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func getStarsImage(with stars: Double) {
        switch stars {
        case 0..<1:
            let star1 = UIImageView(image: UIImage(named: "star1"))
            starsStackView.addArrangedSubview(star1)
            for _ in 1...4 {
                let star = UIImageView(image: UIImage(named: "star"))
                starsStackView.addArrangedSubview(star)
            }
        case 1..<2:
            for _ in 1...2 {
                let star1 = UIImageView(image: UIImage(named: "star1"))
                starsStackView.addArrangedSubview(star1)
            }
            for _ in 1...3 {
                let star = UIImageView(image: UIImage(named: "star"))
                starsStackView.addArrangedSubview(star)
            }
        case 2..<3:
            for _ in 1...3 {
                let star1 = UIImageView(image: UIImage(named: "star1"))
                starsStackView.addArrangedSubview(star1)
            }
            for _ in 1...2 {
                let star = UIImageView(image: UIImage(named: "star"))
                starsStackView.addArrangedSubview(star)
            }
        case 3..<4:
            for _ in 1...4 {
                let star1 = UIImageView(image: UIImage(named: "star1"))
                starsStackView.addArrangedSubview(star1)
            }
            let star = UIImageView(image: UIImage(named: "star"))
            starsStackView.addArrangedSubview(star)
        case 4...5:
            for _ in 1...5 {
                let star1 = UIImageView(image: UIImage(named: "star1"))
                starsStackView.addArrangedSubview(star1)
            }
        default:
            return
        }
    }
}

//MARK: - Setup UI
extension DetailViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        title = "Book Detail"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back-button-icon"),
            style: .done, target: self, action: #selector(didTapBack)
        )
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainScrollView)
        
        let views = [bookImageView, bookNameLabel, starsStackView, storyLineLabel, textView, dateOfPublicationLabel]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainScrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bookImageView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 30),
            bookImageView.heightAnchor.constraint(equalToConstant: 300),
            bookImageView.widthAnchor.constraint(equalToConstant: 225),
            bookImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookNameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 30),
            bookNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bookNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            starsStackView.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 30),
            starsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            storyLineLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 30),
            storyLineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            textView.topAnchor.constraint(equalTo: storyLineLabel.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            dateOfPublicationLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 30),
            dateOfPublicationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            dateOfPublicationLabel.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -30)
        ])
    }
}
