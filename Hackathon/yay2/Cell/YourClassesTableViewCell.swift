//
//  YourClassesTableViewCell.swift
//  yay2
//
//  Created by Lillian Joyce on 4/18/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import UIKit

class YourClassesTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var labelHeight: CGFloat = 16
    //var yourclasses: YourClasses
    
    let padding: CGFloat = 8

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
    }
    
    func configure(for urclass: YourClasses){
        nameLabel.text = urclass.classname
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
