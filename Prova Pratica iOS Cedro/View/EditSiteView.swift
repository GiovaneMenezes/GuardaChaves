//
//  EditSiteView.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 19/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit

class EditSiteView: InsertSiteView {
    
    var site: Site? {
        didSet {
            nomeText.text = site?.name
            loginText.text = site?.login
            senhaText.text = site?.password
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLabel.text = "Editar Chave"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
