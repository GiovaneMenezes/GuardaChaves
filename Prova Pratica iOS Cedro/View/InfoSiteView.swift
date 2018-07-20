//
//  EditSiteView.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 18/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class InfoSiteView: ModalView{
    
    var senhaOculta = true
    
    var site: Site? {
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        siteContentLabel.text = site?.name
        loginContentLabel.text = site?.login
        passwordContentLabel.text = "********"
        logoView.image = site?.getImage()
        
        senhaOculta = false
        mostrarSenha()
    }
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "CREDENCIAL"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    let logoView: UIImageView = {
        let logoView = UIImageView(image: #imageLiteral(resourceName: "logoHolder"))
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    let siteLabel: UILabel = {
        let siteLabel = UILabel()
        siteLabel.text = "Site:"
        siteLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return siteLabel
    }()
    
    let siteContentLabel: UILabel = {
        let siteContentLabel = UILabel()
        return siteContentLabel
    }()
    
    let loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Login:"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return loginLabel
    }()
    
    let loginContentLabel: UILabel = {
        let loginContentLabel = UILabel()
        return loginContentLabel
    }()
    
    let passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.text = "Senha:"
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return passwordLabel
    }()
    
    let passwordContentLabel: UILabel = {
        let passwordContentLabel = UILabel()
        return passwordContentLabel
    }()
    
    let showButton: UIButton = {
        let showButton = UIButton()
        showButton.setImage(#imageLiteral(resourceName: "eye_green"), for: .normal)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        return showButton
    }()
    
    let optionButton: UIButton = {
        let optionButton = UIButton()
        optionButton.setTitle("Outras opções", for: .normal)
        optionButton.setTitleColor(UIColor.blue, for: .normal)
        optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        return optionButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordContentLabel, showButton])
        passwordStackView.axis = .horizontal
        passwordStackView.distribution = .equalSpacing
        passwordStackView.alignment = .fill
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.autoresizesSubviews = true
        
        let fieldsStackView = UIStackView(arrangedSubviews: [siteLabel, siteContentLabel, loginLabel, loginContentLabel, passwordLabel, passwordStackView])
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.alignment = .fill
        fieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldsStackView.autoresizesSubviews = true
        
        container.addSubview(headerLabel)
        container.addSubview(logoView)
        container.addSubview(fieldsStackView)
        container.addSubview(optionButton)
        
        headerLabel.topAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        showButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        logoView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20).isActive = true
        logoView.topAnchor.constraint(equalTo: fieldsStackView.topAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        logoView.image = self.site?.getImage()
        
        fieldsStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25).isActive = true
        fieldsStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        fieldsStackView.leftAnchor.constraint(equalTo: logoView.rightAnchor, constant: 20).isActive = true
        fieldsStackView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20).isActive = true
        
        optionButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15).isActive = true
        optionButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        optionButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        optionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        showButton.addTarget(self, action: #selector(mostrarSenha), for: .touchUpInside)
        
    }
    
    
    
    @objc func mostrarSenha(){
        if senhaOculta {
            passwordContentLabel.text = site?.password!
            showButton.setImage(#imageLiteral(resourceName: "eye_red"), for: .normal)
            senhaOculta = false
        } else {
            passwordContentLabel.text = "********"
            showButton.setImage(#imageLiteral(resourceName: "eye_green"), for: .normal)
            senhaOculta = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
