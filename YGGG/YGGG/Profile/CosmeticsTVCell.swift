//
//  CosmeticsTVCell.swift
//  YGGG
//
//  Created by Chung Wussup on 6/5/24.
//

import UIKit

class CosmeticsTVCell: UITableViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 248/255, green: 245/255, blue: 245/255, alpha: 1.0)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let cosmaticsImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "waterbottle")
        return iv
    }()
    
    
    private let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 12
        
        return sv
    }()
    
    
    let cosmeticLabel: UILabel = {
        let label = UILabel()
        label.text = "로션"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical

        return sv
    }()
    
    let purchaseDataLabel: UILabel = {
       let label = UILabel()
        label.text = "구매날짜: \(Date())"
        return label
    }()
    
    let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "유통기한: \(Date())"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func configureUI() {
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 137)
        ])
        
        mainView.addSubview(cosmaticsImageView)
        NSLayoutConstraint.activate([
            cosmaticsImageView.widthAnchor.constraint(equalToConstant: 78),
            cosmaticsImageView.heightAnchor.constraint(equalToConstant: 87),
            cosmaticsImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25),
            cosmaticsImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 23),
            cosmaticsImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -25)
        ])
        
        
        mainView.addSubview(mainStackView)
        
        [cosmeticLabel, dateStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [purchaseDataLabel, expirationDateLabel].forEach {
            dateStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: cosmaticsImageView.trailingAnchor, constant: 18),
            mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15)
        ])
        
    }
    
}
