//
//  DetailHeroeViewController.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import Foundation
import UIKit

class DetailHeroeViewController: UIViewController {
    
    //MARK: - Properties
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private var heroeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var heroeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.text = "Loading..."
        return label
    }()
    
    private var descriptionHeroeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.text = "Description:"
        return label
    }()
    
    private var descriptionHeroeTwoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 20
        label.text = "Loading..."
        return label
    }()
    
    private var comicsHeroeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 20
        label.text = "Comics:"
        return label
    }()
    
    private lazy var comicsCollectionview: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        
        collection.setCollectionViewLayout(layout, animated: true)
        collection.register(HeroeSerieCell.self, forCellWithReuseIdentifier: AppConstans.REUSE_IDENTIFIER_HEROE_COMIC_COLLECTION)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    private var viewModel: DetailHeroViewModel!
    private var heroeID: Int
    
    //MARK: - Lifecycle
    init(heroeID: Int) {
        self.heroeID = heroeID
        viewModel = DetailHeroViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBarInViewController(largeTitleColor: .blue, backgoundColor: .white, tintColor: .blue, title: "Description", preferredLargeTitle: true)
        
        viewModel.getHeroe(heroeID: heroeID)
        bind()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollView.addSubview(heroeImageView)
        
        heroeImageView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, width: UIScreen.main.bounds.size.width, height: 250)
        
        scrollView.addSubview(heroeNameLabel)
        
        heroeNameLabel.anchor(top: heroeImageView.bottomAnchor, left: heroeImageView.leftAnchor, right: heroeNameLabel.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        
        let stackDescription = UIStackView(arrangedSubviews: [descriptionHeroeLabel, descriptionHeroeTwoLabel])
        stackDescription.axis = .vertical
        stackDescription.spacing = 2
        stackDescription.distribution = .equalSpacing
        
        let mainStack = UIStackView(arrangedSubviews: [stackDescription])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.distribution = .equalSpacing
        
        scrollView.addSubview(mainStack)
        mainStack.anchor(top: heroeNameLabel.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 2, paddingLeft: 10, paddingRight: 10)
        
        scrollView.addSubview(comicsHeroeLabel)
        comicsHeroeLabel.anchor(top: mainStack.bottomAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
        
        scrollView.addSubview(comicsCollectionview)
        comicsCollectionview.anchor(top: comicsHeroeLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, height: 220)
    }
    
    //MARK: - Helpers
    private func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            if error == true {
                self?.showError()
            }
        }
        
        viewModel.heroeResponse.observe(on: self) { [weak self] _ in
            self?.setupLabels()
            self?.comicsCollectionview.reloadData()
        }
    }
    
    private func showError() {
        
    }
    
    private func setupLabels() {
        heroeImageView.sd_setImage(with: viewModel.urlImage, completed: nil)
        heroeNameLabel.text = viewModel.heroeName
        descriptionHeroeTwoLabel.text = viewModel.description
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension DetailHeroeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfComics
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstans.REUSE_IDENTIFIER_HEROE_COMIC_COLLECTION, for: indexPath) as? HeroeSerieCell else { fatalError() }
        cell.comicsItem = viewModel.getComicItem(indexPath: indexPath.row)
        
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DetailHeroeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 200)
    }
}

