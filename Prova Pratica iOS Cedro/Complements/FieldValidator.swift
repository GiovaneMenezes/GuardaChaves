//
//  FieldValidator.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 17/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import Foundation

class FieldValidator {
    static func login(email:String?, senha:String?) -> String?{
        if email == "" || email == nil{
            return "Insira um email válido"
        } else if senha == "" || senha == nil{
            return "A senha deverá conter no mínimo 8 caracteres, dos quais deve possuir no mínimo 1 letra, 1 número e 1 caractere especial."
        }
        return nil
    }
    static func cadastro(email:String?, senha:String?, nome:String?) -> String?{
        if email == "" || email == nil{
            return "Insira um email válido"
        } else if senha == "" || senha == nil{
            return "A senha deve`rá conter no mínimo 8 caracteres, dos quais deve possuir no mínimo 1 letra, 1 número e 1 caractere especial."
        } else if nome == "" || nome == nil{
            return "Insira um nome válido"
        } else if (senha?.count)! < 8{
            return "A senha deverá conter no mínimo 8 caracteres, dos quais deve possuir no mínimo 1 letra, 1 número e 1 caractere especial."
        } else{
            let patterns = ["[a-z]|[A-Z]","[0-9]","[!@#$%^&*()_+\\-=\\[\\]{};':,.<>?]"]
            for pat in patterns{
                let regex = try! NSRegularExpression(pattern: pat, options: [])
                let matches = regex.numberOfMatches(in: senha!, options: [], range: NSRange(location: 0, length: senha!.count))
                if matches < 1{
                    return "A senha deverá conter no mínimo 8 caracteres, dos quais deve possuir no mínimo 1 letra, 1 número e 1 caractere especial."
                }
                
            }
        }
        return nil
    }
}
