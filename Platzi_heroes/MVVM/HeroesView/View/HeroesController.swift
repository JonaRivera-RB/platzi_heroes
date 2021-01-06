//
//  HeroesController.swift
//  Platzi_heroes
//
//  Created by Jonathan Rivera Misael on 05/01/21.
//

import UIKit

class HeroesController: UICollectionViewController {
    
    private var viewModel: HeroesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        viewModel = HeroesViewModel()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        viewModel.getHeroes()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
    private func configureCollectionView() {
        configureNavigationBarInViewController(largeTitleColor: .blue, backgoundColor: .white, tintColor: .blue, title: AppConstans.navigationTitleHome, preferredLargeTitle: true)
        
        view.backgroundColor = .white
        collectionView.register(HeroeCell.self, forCellWithReuseIdentifier: AppConstans.REUSE_IDENTIFIER_HEROE_COLLECTION)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            if error == true {
                self?.showError()
            }
        }
        
        viewModel.heroesResponse.observe(on: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    private func showError() {
        
    }
}

//MARK: DataSource
extension HeroesController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstans.REUSE_IDENTIFIER_HEROE_COLLECTION, for: indexPath) as? HeroeCell else { fatalError() }
        cell.heroeList = viewModel.getHeroe(indexPath: indexPath.row)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfItemsInSections - 1 {
            viewModel.nextPage()
            viewModel.getHeroes()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailHeroeViewController(heroeID: viewModel.getHeroeID(indexPath: indexPath.row))
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension HeroesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 2
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(columns - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(columns))
        
        return CGSize(width: size, height: 300)
    }
}
