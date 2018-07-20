//
//  LoginController.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 12/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class LoginController: UIViewController {

    var msg: String?
    var user: User?
    
    var modoTela: String = "login"
    var biometrics = BiometricIDAuth()
    
    let loadingView = LoadingView()
    
    var emailTextView_y_1: NSLayoutConstraint!
    var emailTextView_y_2: NSLayoutConstraint!
    
    let nomeTextView: UITextField = {
        var nomeTextView = UITextField()
        nomeTextView.translatesAutoresizingMaskIntoConstraints = false
        nomeTextView.placeholder = "Nome"
        nomeTextView.isHidden = true
        nomeTextView.setBottomBorder()
        return nomeTextView
    }()
    
    let emailTextView: UITextField = {
        var emailTextView = UITextField()
        emailTextView.translatesAutoresizingMaskIntoConstraints = false
        emailTextView.placeholder = "E-mail"
        emailTextView.keyboardType = .emailAddress
        emailTextView.autocapitalizationType = .none
        emailTextView.setBottomBorder()
        return emailTextView
    }()
    
    let passwordTextView: UITextField = {
        var passwordTextView = UITextField()
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextView.placeholder = "Senha"
        passwordTextView.isSecureTextEntry = true
        passwordTextView.setBottomBorder()
        return passwordTextView
    }()
    
    let logoImageView: UIImageView = {
        var logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let confirmUIButton: UIButton = {
        var confirmUIButton = UIButton()
        confirmUIButton.translatesAutoresizingMaskIntoConstraints = false
        confirmUIButton.setTitle("ENTRAR", for: .normal)
        confirmUIButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        confirmUIButton.backgroundColor = UIColor.blue
        return confirmUIButton
    }()
    
    let modeUIButton: UIButton = {
        var modeUIButton = UIButton()
        modeUIButton.translatesAutoresizingMaskIntoConstraints = false
        modeUIButton.setTitle("CADASTRE-SE", for: .normal)
        modeUIButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        modeUIButton.backgroundColor = UIColor.gray
        return modeUIButton
    }()
    
    let cadastroUILabel: UILabel = {
        var cadastroUILabel = UILabel()
        cadastroUILabel.translatesAutoresizingMaskIntoConstraints = false
        cadastroUILabel.text = "Ainda não é cadastrado?"
        cadastroUILabel.textColor = UIColor.gray
        return cadastroUILabel
    }()
    
    let touchIdButton: UIButton = {
        var touchIdButton = UIButton()
        touchIdButton.translatesAutoresizingMaskIntoConstraints = false
        touchIdButton.setTitle("Entrar com TouchId", for: .normal)
        touchIdButton.setTitleColor(UIColor.blue, for: .normal)
        touchIdButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return touchIdButton
    }()
    
    
    fileprivate func setupLayout() {
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        view.addSubview(nomeTextView)
        nomeTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
        nomeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nomeTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nomeTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(emailTextView)
        emailTextView_y_1 = emailTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30)
        emailTextView_y_2 = emailTextView.topAnchor.constraint(equalTo: nomeTextView.bottomAnchor, constant: 15)
        emailTextView_y_1.isActive = true
        emailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(passwordTextView)
        passwordTextView.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant:15).isActive = true
        passwordTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(confirmUIButton)
        confirmUIButton.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant:30).isActive = true
        confirmUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmUIButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        confirmUIButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        confirmUIButton.addTarget(self, action: #selector(confirmar), for: .touchUpInside)
        
        view.addSubview(touchIdButton)
        touchIdButton.topAnchor.constraint(equalTo: confirmUIButton.bottomAnchor, constant: 10).isActive = true
        touchIdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        touchIdButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        touchIdButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(modeUIButton)
        modeUIButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        modeUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modeUIButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        modeUIButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modeUIButton.addTarget(self, action: #selector(mudarModo), for: .touchUpInside)
        
        view.addSubview(cadastroUILabel)
        cadastroUILabel.bottomAnchor.constraint(equalTo: modeUIButton.topAnchor, constant: -15).isActive = true
        cadastroUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        loadingView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        setupLayout()
        
        checkIfExistsSavedKey()
    }
    
    fileprivate func activateTouchID() {
        if !UserDefaults.standard.bool(forKey: "isSavedPassword") && self.biometrics.canEvaluatePolicy(){
            let setTouchIDAlertView = UIAlertController(title: "Adicionar touchID", message: "Deseja adicionar touchID para este usuário?", preferredStyle: .alert)
            setTouchIDAlertView.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action:UIAlertAction) in
                UserDefaults.standard.set(self.emailTextView.text!.lowercased(), forKey: "savedUser")
                do{
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                            account: UserDefaults.standard.string(forKey: "savedUser")!,
                                                            accessGroup: KeychainConfiguration.accessGroup)
                    try passwordItem.savePassword(self.passwordTextView.text!)
                } catch{
                    fatalError("Error updating keychain - \(error)")
                }
                self.changeScreen(usuario: self.user!)
            }))
            setTouchIDAlertView.addAction(UIAlertAction(title: "Não", style: .default, handler: { (action:UIAlertAction) in
                self.changeScreen(usuario: self.user!)
            }))
            UserDefaults.standard.set(true, forKey: "isSavedPassword")
            self.present(setTouchIDAlertView, animated: true, completion: nil)
        } else{
            self.changeScreen(usuario: user!)
        }
    }
    
    @objc func confirmar(){
        var url: String!
        
        var parameters: Parameters!
        
        let header: HTTPHeaders = [
            "content-type":"application/json"
        ]
        
        if modoTela == "login"{
            msg = FieldValidator.login(email: emailTextView.text, senha: passwordTextView.text)
            if msg == nil {
                
                url = "https://dev.people.com.ai/mobile/api/v2/login"
                parameters = [
                    "email":emailTextView.text!.lowercased(),
                    "password":passwordTextView.text!
                ]
                loadingView.isHidden = false
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                    if response.response?.statusCode == 201{
                        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                        fetchRequest.predicate = NSPredicate(format: "email = %@", self.emailTextView.text!.lowercased())
                        do{
                            let users = try PersistenceService.context.fetch(fetchRequest)
                            if users.count > 0{
                                self.user = users.first
                            } else{
                                self.user = User(context: PersistenceService.context)
                                self.user!.email = self.emailTextView.text!.lowercased()
                                PersistenceService.saveContext()
                            }
                        } catch {
                            print(error)
                        }
                        let JSON = response.result.value as! NSDictionary
                        self.user?.token = JSON["token"] as? String
                        print(JSON["token"]!)
                        self.activateTouchID()
                    }
                    else if response.response?.statusCode == 403 {
                        self.msg = "Login e/ou senha incorretos"
                    }
                    else {
                        self.msg = "Erro ao efetuar login"
                    }
                    if self.msg != nil{
                        self.loadingView.isHidden = true
                        let erroAlertController = UIAlertController(title: "Erro no login", message: self.msg!, preferredStyle: .alert)
                        erroAlertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                        self.present(erroAlertController, animated: true, completion: nil)
                    }
                }
            }
            
        }
        if modoTela == "cadastro"{
            msg = FieldValidator.cadastro(email: emailTextView.text, senha: passwordTextView.text, nome:nomeTextView.text)
            if msg == nil {
                url = "https://dev.people.com.ai/mobile/api/v2/register"
                parameters = [
                    "email":emailTextView.text!.lowercased(),
                    "password":passwordTextView.text!,
                    "name":nomeTextView.text!
                ]
                loadingView.isHidden = true
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                    if response.response?.statusCode == 201{
                        self.user = User(context: PersistenceService.context)
                        PersistenceService.saveContext()
                        self.user!.email = self.emailTextView.text!.lowercased()
                        self.activateTouchID()
                        let JSON = response.result.value as! NSDictionary
                        self.user?.token = JSON["token"] as? String
                        self.changeScreen(usuario: self.user!)
                    }
                    if response.response?.statusCode == 409 {
                        self.msg = "Esse email já está cadastrado"
                    }
                    else {
                        self.msg = "Erro ao cadastrar usuário"
                    }
                    if self.msg != nil{
                        self.loadingView.isHidden = true
                        let erroAlertController = UIAlertController(title: "Erro no login", message: self.msg!, preferredStyle: .alert)
                        erroAlertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                        self.present(erroAlertController, animated: true, completion: nil)
                    }
                }
            }
        }
        if msg != nil{
            let erroAlertController = UIAlertController(title: "Erro no login", message: msg!, preferredStyle: .alert)
            erroAlertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            self.present(erroAlertController, animated: true, completion: nil)
        }
    }
    
    func changeScreen(usuario: User){
        let sitesTableViewController = SitesTableViewController()
        sitesTableViewController.usuario = usuario
        self.present(sitesTableViewController, animated: true, completion: nil)
    }
    
    @objc func mudarModo(sender: UIButton!){
        if modoTela == "login" {
            confirmUIButton.setTitle("CADASTRAR", for: .normal)
            modeUIButton.setTitle("ENTRAR", for: .normal)
            cadastroUILabel.text = "Já é cadastrado?"
            
            self.nomeTextView.isHidden = false
            emailTextView_y_1.isActive = false
            emailTextView_y_2.isActive = true
            
            passwordTextView.text = nil
            
            modoTela = "cadastro"
        }
        else if modoTela == "cadastro" {
            confirmUIButton.setTitle("ENTRAR", for: .normal)
            modeUIButton.setTitle("CADASTRE-SE", for: .normal)
            cadastroUILabel.text = "Ainda não é cadastrado?"
            
            checkIfExistsSavedKey()
            
            self.nomeTextView.isHidden = true
            emailTextView_y_2.isActive = false
            emailTextView_y_1.isActive = true
            
            passwordTextView.text = nil
            
            modoTela = "login"
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func touchIDLoginAction() {
        biometrics.authenticateUser() { [weak self] message in
            if let message = message {
                let alertView = UIAlertController(title: "Erro",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Cancelar", style: .cancel)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
            } else {
                do{
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                            account: UserDefaults.standard.string(forKey: "savedUser")!,
                                                            accessGroup: KeychainConfiguration.accessGroup)
                    self?.passwordTextView.text = try passwordItem.readPassword()
                    self?.confirmar()
                } catch{
                    fatalError("Error reading password from keychain - \(error)")
                }
            }
        }
    }
    
    func checkIfExistsSavedKey(){
        if UserDefaults.standard.bool(forKey: "isSavedPassword") {
            touchIdButton.isHidden = false
            emailTextView.text = UserDefaults.standard.string(forKey: "savedUser")!
            touchIDLoginAction()
        }
        else{
            touchIdButton.isHidden = true
        }
    }
    
    struct KeychainConfiguration {
        static let serviceName = "GuardaChaves"
        static let accessGroup: String? = nil
    }
    
    var passwordItens: [KeychainPasswordItem] = []
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
