//
//  ProfileViewController.swift
//  YGGG
//
//  Created by Chung Wussup on 6/5/24.
//

import UIKit

struct TopCategory {
    let imageName: String
    let title: String
}
//User, User Item List, Favorite, items Count
class ProfileViewController: UIViewController {
    
    var topCategorys: [TopCategory] = [
        TopCategory(imageName: "allmenu", title: "전체"),
        TopCategory(imageName: "snowflake", title: "냉동"),
        TopCategory(imageName: "fridge", title: "냉장"),
        TopCategory(imageName: "body", title: "실온")
    ]
    
    var categorySelectedIndex: IndexPath?
    
    private let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 38
        iv.layer.masksToBounds = true
        iv.image = UIImage(systemName: "person.circle")
        return iv
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    private let profileStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 2
        sv.axis = .vertical
        return sv
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ruel"
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    private let tagLabel: UILabel = {
       let label = UILabel()
        label.text = "#건조 #수부지 #민감성 #홍조"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let cosmeticsStackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.spacing = 10
        sv.distribution = .fill
        return sv
    }()
    
    private let refrigeratorButton: UIButton = {
        let button = UIButton()
        button.setTitle("냉장고 0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let tombButton: UIButton = {
        let button = UIButton()
        button.setTitle("무덤 0", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let emptyView: UIView = {
       let view = UIView()
        return view
    }()
    
    
    private lazy var categoryCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 83, height: 39)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 19, bottom: 15, right: 19)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: "CategoryCVCell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var cosmeticsTV: UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.rowHeight = 148
        tv.register(CosmeticsTVCell.self, forCellReuseIdentifier: "CosmeticsTVCell")
        tv.separatorStyle = .none
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        categorySelectedIndex = IndexPath(row: 0, section: 0)
        categoryCV.selectItem(at: categorySelectedIndex, animated: false, scrollPosition: .left)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(profileView)
        
        navigationController?.navigationBar.backgroundColor = .blue
        
        [profileImageView, profileStackView, favoriteButton, categoryCV, cosmeticsTV].forEach {
            view.addSubview($0)
        }
        
        [nickNameLabel, tagLabel, cosmeticsStackView].forEach {
            profileStackView.addArrangedSubview($0)
        }
        
        [refrigeratorButton, tombButton, emptyView].forEach {
            cosmeticsStackView.addArrangedSubview($0)
        }
        
        //profileView Constraint Setting
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        //profileImageView Constraint Setting
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 76),
            profileImageView.heightAnchor.constraint(equalToConstant: 76),
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 33),
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 32)
        ])
        
        //profileStackView Constraint Setting
        NSLayoutConstraint.activate([
            profileStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            profileStackView.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -20)
            
        ])
        
        //favoriteButton Constraint Setting
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: 23),
            favoriteButton.heightAnchor.constraint(equalToConstant: 23),
            favoriteButton.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 65),
            favoriteButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -42)
        ])
        
        //categoryCV Constraint Setting
        NSLayoutConstraint.activate([
            categoryCV.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            categoryCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCV.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        //cosmeticsTV Constraint Setting
        NSLayoutConstraint.activate([
            cosmeticsTV.topAnchor.constraint(equalTo: categoryCV.bottomAnchor),
            cosmeticsTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cosmeticsTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cosmeticsTV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCategorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell {
            cell.configureCell(category: topCategorys[indexPath.row])
            cell.isSelected = (indexPath == categorySelectedIndex)
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.categorySelectedIndex = indexPath
//        collectionView.reloadData()
//    }

    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CosmeticsTVCell", for: indexPath) as? CosmeticsTVCell {
            cell.configureUI()
            return cell
        }
        return UITableViewCell()
    }
    
    
}
