//
//  SiteTableViewCell.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 13/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell {
    
    var site: Site? {
        didSet {
            siteLabelView.text = site?.name
            usuarioLabelView.text = site?.login
            logoImageView.image = site?.getImage()
        }
    }
    
    var logoImage: UIImage? {
        didSet {
            logoImageView.image = logoImage
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let siteLabelView: UILabel = {
        var siteLabelView = UILabel()
        siteLabelView.translatesAutoresizingMaskIntoConstraints = false
        siteLabelView.font = UIFont.boldSystemFont(ofSize: 17)
        return siteLabelView
    }()
    
    let usuarioLabelView: UILabel = {
        var usuarioLabelView = UILabel()
        usuarioLabelView.translatesAutoresizingMaskIntoConstraints = false
        return usuarioLabelView
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    let logoImageView: UIImageView = {
        var logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    func setupViews(){
        
        self.contentView.addSubview(logoImageView)
        logoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.logoImageView.trailingAnchor, constant: 10).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        let infoStackView = UIStackView(arrangedSubviews: [siteLabelView, usuarioLabelView])
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.alignment = .center
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .vertical
        
        containerView.addSubview(infoStackView)
        infoStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        infoStackView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        infoStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
    }
}
