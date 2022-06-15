//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import UIKit
import SnapKit

class DetailsViewController: BaseViewController<DetailsViewModel> {
    
    private var isOpen: Bool = false
    
    private var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        scroll.isDirectionalLockEnabled = true
        return scroll
    }()
    
    private var mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let imgCharacter: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    private let descriptionView: UIView = {
       let view = UIView()
        view.backgroundColor = .customBackgroundColor1.withAlphaComponent(0.75)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let lblDescriptions: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let lblGender: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let episodeView: UIView = {
       let view = UIView()
        view.backgroundColor = .customBackgroundColor1.withAlphaComponent(0.75)
        view.layer.cornerRadius = 20
        view.layer.zPosition = 3
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private var lblEpisodes: UILabel = {
       let label = UILabel()
        label.text = "Episodes"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Nunito-ExtraBold", size: 16)
        return label
    }()
    
    private var episodeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.layer.zPosition = 5
        button.addTarget(self, action: #selector(episodeViewTapped), for: .touchUpInside)
        return button
    }()
    
    private var episodeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var tableView: UITableView = {
       let table = UITableView()
        table.register(UINib(nibName: "EpisodesTableViewCell", bundle: nil),
                       forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.backgroundColor = .clear
        table.bounces = false
        table.isScrollEnabled = false
        table.estimatedRowHeight = EpisodesTableViewCell.rowHeight
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initViewModelDelegate()
        showSpinner(onView: self.view)
        viewModel.getCharacterDetail()
    }
    
    private func initViewModelDelegate() {
        
        viewModel.delegate = self
    }
    
    private func setUI() {
        
        self.view.addSubview(scrollView)
    
        scrollView.addSubview(mainView)
        
        mainView.addSubview(imgCharacter)
        mainView.addSubview(descriptionView)
        mainView.addSubview(episodeView)
        mainView.addSubview(episodeButton)
        mainView.addSubview(tableView)
        
        descriptionView.addSubview(lblDescriptions)
        descriptionView.addSubview(lblGender)
        
        episodeView.addSubview(lblEpisodes)
        episodeView.addSubview(episodeImageView)

        //Scroll View
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        //Main View
        mainView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
        
        //Character Image View
        imgCharacter.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.33)
            make.height.equalTo(imgCharacter.snp.width)
            make.top.equalTo(mainView.snp.top).offset(20)
            make.left.equalTo(mainView.snp.left).offset(10)
        }
        
        //Character Description View
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(imgCharacter.snp.top)
            make.bottom.equalTo(imgCharacter.snp.bottom)
            make.left.equalTo(imgCharacter.snp.right).offset(10)
            make.right.equalTo(scrollView.snp.right).offset(-10)
        }
        
        //Character Description Label
        lblDescriptions.snp.makeConstraints { make in
            make.height.equalTo(imgCharacter.snp.width).multipliedBy(0.4)
            make.top.equalTo(descriptionView.snp.top).offset(10)
            make.right.equalTo(descriptionView.snp.right).offset(-10)
            make.left.equalTo(descriptionView.snp.left).offset(10)
        }
        
        //Character Gender Label
        lblGender.snp.makeConstraints { make in
            make.top.equalTo(lblDescriptions.snp.bottom).offset(10)
            make.right.equalTo(lblDescriptions.snp.right)
            make.left.equalTo(lblDescriptions.snp.left)
            make.bottom.equalTo(descriptionView.snp.bottom).offset(-10)
        }
        
        //Episode View
        episodeView.snp.makeConstraints { make in
            make.height.equalTo(imgCharacter.snp.height).multipliedBy(0.4)
            make.top.equalTo(imgCharacter.snp.bottom).offset(10)
            make.left.equalTo(mainView.snp.left).offset(10)
            make.right.equalTo(mainView.snp.right).offset(-10)
        }
        
        //Episode Button
        episodeButton.snp.makeConstraints { make in
            make.height.equalTo(imgCharacter.snp.height).multipliedBy(0.4)
            make.top.equalTo(episodeView.snp.top)
            make.left.equalTo(episodeView.snp.left)
            make.right.equalTo(episodeView.snp.right)
        }
        
        //Episode Label
        lblEpisodes.snp.makeConstraints { make in
            make.top.equalTo(episodeView.snp.top).offset(10)
            make.bottom.equalTo(episodeView.snp.bottom).offset(-10)
            make.left.equalTo(episodeView.snp.left).offset(10)
        }

        //Episode Button Down-Up Image
        episodeImageView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.top.equalTo(lblEpisodes.snp.top)
            make.bottom.equalTo(lblEpisodes.snp.bottom)
            make.right.equalTo(episodeView.snp.right).offset(-20)
            make.left.equalTo(lblEpisodes.snp.right).offset(10)
        }
        
        //Episode Table View
        tableView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(0)
            make.top.equalTo(episodeButton.snp.bottom)
            make.left.equalTo(mainView.snp.left).offset(10)
            make.right.equalTo(mainView.snp.right).offset(-10)
            make.bottom.equalTo(mainView.snp.bottom).offset(-10)
        }
    }
    
    //Episode Button Method
    @objc private func episodeViewTapped() {
        
        if isOpen {
            animate(isOpen: false,
                    imageName: "down",
                    heightConstraint: 0)
        } else {
            let tableviewHeight = EpisodesTableViewCell.rowHeight * CGFloat(viewModel.episodes.count) + 360
            let height = !viewModel.episodes.isEmpty ? tableviewHeight : EpisodesTableViewCell.rowHeight

            animate(isOpen: true,
                    imageName: "up",
                    heightConstraint: height)
        }
    }
    
    //Episode Button Animation
    private func animate(isOpen: Bool,
                         imageName: String,
                         heightConstraint: CGFloat) {
        
        self.isOpen = isOpen
        tableView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(heightConstraint)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.episodeImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self.view.layoutIfNeeded()
        }
    }
    
    //Set Data Method
    private func setData() {
        
        guard let character = viewModel.character,
              let imageUrl = character.image,
              let episodes = viewModel.character?.episode else { return }
        
        title = character.name
        lblDescriptions.attributedText = (character.status~ + ", " + character.species~).getAttributeString(for: "Status/Species: ")
        lblGender.attributedText = character.gender~.getAttributeString(for: "Gender: ")
        imgCharacter.loadImageUsingCache(withUrl: imageUrl)
        viewModel.getEpisodes(for: episodes)
    }
    
    //Empty State Method
    private func setEmptyState() {
        
        title = "No Character"
        imgCharacter.image = UIImage(named: "empty")
        lblDescriptions.attributedText = "-".getAttributeString(for: "Status/Species: ")
        lblGender.attributedText = "-".getAttributeString(for: "Gender: ")
    }
}

//MARK: - Data Fetch Protocol
extension DetailsViewController: CharacterDataReached {
    
    func dataReached(data: SingleCharacter) {
        
        DispatchQueue.main.async {
            self.setData()
        }
        removeSpinner()
    }
    
    func episodeDataReached(data: [String]) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorReached(data: String?) {
        
        guard let errorMessage = data else { return }
        DispatchQueue.main.async {
            self.createAlert(for: errorMessage)
            self.setEmptyState()
        }
        removeSpinner()
    }
}

//MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier,
                                                 for: indexPath) as! EpisodesTableViewCell
        if !viewModel.episodes.isEmpty {
            cell.episode = viewModel.episodes[indexPath.row]
        } else {
            cell.episode = EpisodeModel(error: nil,
                                        id: nil,
                                        name: "Character is not found",
                                        episode: nil)
        }

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodes.isEmpty ? 1 : viewModel.episodes.count
    }
}

