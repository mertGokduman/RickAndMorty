//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController<MainViewModel> {
    
    private var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.layer.cornerRadius = 20
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil),
                            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        return collection
    }()
    
    private var emptyView: UIView = {
       let view = UIView()
        view.backgroundColor = .customBackgroundColor1
        view.layer.cornerRadius = 40
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0,
                                         height: 10)
        return view
    }()
    
    private var imgEmty: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "empty")
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var lblEmpty: UILabel = {
       let label = UILabel()
        label.text = "There is no character"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-ExtraBold", size: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        setUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initViewModel()
        showSpinner(onView: self.view)
        viewModel.getCharacters(isPagination: false)
    }
    
    private func initViewModel(){
        viewModel = MainViewModel(delegate: self)
    }
    
    private func setUI() {
        
        self.view.addSubview(collectionView)
        self.view.addSubview(emptyView)
        emptyView.addSubview(imgEmty)
        emptyView.addSubview(lblEmpty)
        
        emptyView.isHidden = true
        
        //Collection View
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
        
        //Empty State View
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(view.snp.width).multipliedBy(0.66)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        //Empty State Image
        imgEmty.snp.makeConstraints { make in
            make.height.equalTo(emptyView.snp.height).multipliedBy(0.75)
            make.top.equalTo(emptyView.snp.top).offset(20)
            make.left.equalTo(emptyView.snp.left).offset(20)
            make.right.equalTo(emptyView.snp.right).offset(-20)
        }
        
        //Empty State Label
        lblEmpty.snp.makeConstraints { make in
            make.top.equalTo(imgEmty.snp.bottom).offset(10)
            make.left.equalTo(imgEmty.snp.left)
            make.right.equalTo(imgEmty.snp.right)
            make.bottom.equalTo(emptyView.snp.bottom).offset(-20)
        }
    }
}

//MARK: - Data Fetch Protocol
extension MainViewController: DataReachedProtocol {
    
    func dataReached(data: [SingleCharacter]) {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        removeSpinner()
    }
    
    func errorReached(data: AllCharacters) {
        
        guard let errorMessage = data.error else { return }
        DispatchQueue.main.async {
            self.createAlert(for: errorMessage)
            self.collectionView.isHidden = true
            self.emptyView.isHidden = false
        }
        removeSpinner()
    }
}

//MARK: - CollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier,
                                                      for: indexPath) as! CharacterCollectionViewCell
        cell.character = viewModel.allCaracters[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.allCaracters.count
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 70) / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10,
                            left: 10,
                            bottom: 10,
                            right: 10)
    }
}

//MARK: - CollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.viewModel.id = viewModel.allCaracters[indexPath.row].id
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.allCaracters.count - 1 {
            viewModel.getCharacters(isPagination: true)
            showSpinner(onView: self.view)
        }
    }
}
