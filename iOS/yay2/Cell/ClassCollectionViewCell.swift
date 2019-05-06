//
//  ClassCollectionViewCell.swift
//  yay2
//
//  Created by Twesha Modi on 4/26/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {

    var nameLabel: UILabel!
    var deleteClassButton: UIButton!
    weak var delegate: ifDeleteButtonPressedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        
        deleteClassButton = UIButton()
        deleteClassButton.translatesAutoresizingMaskIntoConstraints = false
        deleteClassButton.setTitle("(-)", for: .normal)
        deleteClassButton.setTitleColor(.red, for: .normal)
        deleteClassButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        contentView.addSubview(deleteClassButton)
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            deleteClassButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            deleteClassButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            ])
        
    }
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
//        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//    }
    
    func setup(withClass className: YourClasses) {
        nameLabel.text = className.classname
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func deleteButtonPressed() {
        contentView.removeFromSuperview()
        delegate?.deleteClasses(className: nameLabel.text!)
        
    }
    
    
    
}
    

