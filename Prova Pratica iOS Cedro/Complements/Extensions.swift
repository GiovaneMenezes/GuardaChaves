//
//  Extensions.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 13/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UIViewController {
    
    public func testarInternet() -> Bool{
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            return true
        }
        else{
            let alert = UIAlertController(title: "Erro", message: "Sem conexão com a internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .default, handler: {
                (action:UIAlertAction) in
                return self.testarInternet()
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }

}
