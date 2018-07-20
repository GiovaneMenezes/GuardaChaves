//
//  insertSiteView.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 18/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class InsertSiteView: ModalView {
    
    let confirmaButton: UIButton = {
        let confirmaButton = UIButton()
        confirmaButton.translatesAutoresizingMaskIntoConstraints = false
        confirmaButton.setTitle("SALVAR", for: .normal)
        confirmaButton.backgroundColor = .blue
        return confirmaButton
    }()
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "INSERIR CHAVE"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return headerLabel
    }()
    
    let nomeText: UITextField = {
        var nomeText = UITextField()
        nomeText.translatesAutoresizingMaskIntoConstraints = false
        nomeText.placeholder = "Site (Ex. site.com)"
        nomeText.setBottomBorder()
        nomeText.autocapitalizationType = .none
        return nomeText
    }()
    
    let loginText: UITextField = {
        var loginText = UITextField()
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginText.placeholder = "Login"
        loginText.setBottomBorder()
        loginText.autocapitalizationType = .none
        return loginText
    }()
    
    let senhaText: UITextField = {
        var senhaText = UITextField()
        senhaText.translatesAutoresizingMaskIntoConstraints = false
        senhaText.placeholder = "Senha"
        senhaText.setBottomBorder()
        senhaText.autocapitalizationType = .none
        return senhaText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        container.addSubview(confirmaButton)
        container.addSubview(headerLabel)
        
        let fieldsStackView = UIStackView(arrangedSubviews: [nomeText, loginText, senhaText])
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.alignment = .fill
        fieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldsStackView.autoresizesSubviews = true
        
        container.addSubview(fieldsStackView)
        
        setupContainer()
        
        headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: -10).isActive = true
        
        confirmaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        confirmaButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4).isActive = true
        confirmaButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        confirmaButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        fieldsStackView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9).isActive = true
        fieldsStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15).isActive = true
        fieldsStackView.bottomAnchor.constraint(equalTo: confirmaButton.topAnchor, constant: -15).isActive = true
        fieldsStackView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
    }
    
    override func setupContainer() {
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.40).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.90).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
    }
    
    @objc func cancelarInsercao(){
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
