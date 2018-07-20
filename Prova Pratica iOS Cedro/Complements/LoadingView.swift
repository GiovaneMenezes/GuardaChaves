//
//  LoadingView.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 19/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class LoadingView: UIView {

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
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Carregando..."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(blurredEffectView)
        self.addSubview(container)
        container.addSubview(activityIndicator)
        container.addSubview(label)
        
        blurredEffectView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        blurredEffectView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        blurredEffectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurredEffectView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        activityIndicator.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        label.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
