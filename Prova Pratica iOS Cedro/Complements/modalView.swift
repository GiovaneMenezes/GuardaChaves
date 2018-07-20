//
//  modalView.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 18/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class ModalView: UIView {
    
    let blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    let closeButton: UIButton = {
        let closeButtom = UIButton()
        closeButtom.translatesAutoresizingMaskIntoConstraints = false
        closeButtom.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        return closeButtom
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(blurredEffectView)
        self.addSubview(container)
        container.addSubview(closeButton)
        
        blurredEffectView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        blurredEffectView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        blurredEffectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurredEffectView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        setupContainer()
        
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10).isActive = true
        closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    func setupContainer(){
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.90).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func closeView(){
        self.removeFromSuperview()
    }

}
