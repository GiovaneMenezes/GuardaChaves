//
//  SitesTableViewController.swift
//  Prova Pratica iOS Cedro
//
//  Created by Giovane Silva de Menezes Cavalcante on 16/07/2018.
//  Copyright © 2018 GSMenezes. All rights reserved.
//

import UIKit
import CoreData

import Alamofire
import AlamofireImage

class SitesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var usuario: User!
    
    var site: Site?
    var lastIndexClicked: IndexPath!
    
    var sites = [Site]()
    
    var insertSiteView: InsertSiteView!
    let editSiteView = EditSiteView()
    
    let infoSiteView = InfoSiteView()
    
    let siteTableView: UITableView = {
        let siteTableView = UITableView()
        siteTableView.translatesAutoresizingMaskIntoConstraints = false
        return siteTableView
    }()
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }()
    let appHeaderLabel: UILabel = {
        let appHeaderLabel = UILabel()
        appHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        appHeaderLabel.text = "Guarda Chaves"
        appHeaderLabel.font = UIFont.boldSystemFont(ofSize: 17)
        return appHeaderLabel
    }()
    
    let addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(#imageLiteral(resourceName: "adicionar"), for: .normal)
        addButton.imageView?.clipsToBounds = true
        return addButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        siteTableView.dataSource = self
        siteTableView.delegate = self
        
        view.addSubview(headerView)
        view.addSubview(siteTableView)
        headerView.addSubview(appHeaderLabel)
        headerView.addSubview(addButton)
        
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        appHeaderLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        appHeaderLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 5).isActive = true
        
        addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 5).isActive = true
        addButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.addTarget(self, action: #selector(inserirSite), for: .touchUpInside)
        
        siteTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        siteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        siteTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        siteTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        loadData()
    }
    
    @objc func inserirSite(){
        insertSiteView = InsertSiteView()
        insertSiteView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(insertSiteView)
        
        insertSiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insertSiteView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        insertSiteView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        insertSiteView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        insertSiteView.confirmaButton.addTarget(self, action: #selector(confirmarInsercao), for: .touchUpInside)
    }
    
    func showInfoItem(site: Site){
        infoSiteView.site = site
        infoSiteView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoSiteView)
        infoSiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSiteView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoSiteView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        infoSiteView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        infoSiteView.optionButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
    }
    
    @objc func confirmarInsercao(){
        insertData(name: insertSiteView.nomeText.text!, login: insertSiteView.loginText.text!, password: insertSiteView.senhaText.text!)
        insertSiteView.removeFromSuperview()
    }
    
    @objc func showOptions(){
        let optionsAlertController = UIAlertController(title: "Opções", message: nil, preferredStyle: .actionSheet)
        optionsAlertController.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (alertAction) in
            self.site = self.infoSiteView.site
            
            self.view.addSubview(self.editSiteView)
            
            self.editSiteView.site = self.site
            self.editSiteView.translatesAutoresizingMaskIntoConstraints = false
            
            self.editSiteView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.editSiteView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.editSiteView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            self.editSiteView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            self.editSiteView.confirmaButton.addTarget(self, action: #selector(self.confirmEdit), for: .touchUpInside)
            
            self.siteTableView.reloadData()
            
        }))
        optionsAlertController.addAction(UIAlertAction(title: "Excluir", style: .default, handler: { (alertAction) in
            self.site = self.infoSiteView.site!
            PersistenceService.context.delete(self.site!)
            self.infoSiteView.removeFromSuperview()
            self.sites.remove(at: self.lastIndexClicked.row)
            self.siteTableView.deleteRows(at: [self.lastIndexClicked], with: .automatic)
            PersistenceService.saveContext()
            self.siteTableView.reloadData()
        }))
        optionsAlertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(optionsAlertController, animated: true, completion: nil)
    }
    
    @objc func confirmEdit() {
        editSite(site!, nome: editSiteView.nomeText.text, login: editSiteView.loginText.text, senha: editSiteView.senhaText.text)
        self.editSiteView.removeFromSuperview()
    }
    
    func editSite(_ site:Site!, nome:String!, login:String!, senha:String!){
        site.name = nome
        site.login = login
        site.password = senha
        site.logo = nil
        
        PersistenceService.saveContext()
    }
    
    func insertData(name:String, login:String, password:String){
        let site = Site(context: PersistenceService.context)
        site.name = name
        site.login = login
        site.password = password
        site.user = usuario
        sites.append(site)
        PersistenceService.saveContext()
        siteTableView.reloadData()
    }
    
    func loadData(){
        let fetchRequest: NSFetchRequest<Site> = Site.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user.email = %@", usuario.email!)
        do{
            let sites = try PersistenceService.context.fetch(fetchRequest)
            self.sites = sites
            siteTableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func showEditOptions() {
        
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let siteCell = SiteTableViewCell(style: .default, reuseIdentifier: "Cell")
        siteCell.site = sites[indexPath.row]
        let headers: HTTPHeaders = [
            "authorization": usuario.token!
        ]
        let url = sites[indexPath.row].name!
        if sites[indexPath.row].getImage() == nil {
            Alamofire.request("https://dev.people.com.ai/mobile/api/v2/logo/\(url)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseImage { (response) in
                if response.response?.statusCode == 200{
                    siteCell.logoImage = response.result.value ?? #imageLiteral(resourceName: "logoHolder")
                    self.sites[indexPath.row].setImage(image: response.result.value!)
                    PersistenceService.saveContext()
                } else{
                    siteCell.logoImage = #imageLiteral(resourceName: "logoHolder")
                }
            }
        } else{
            siteCell.logoImage = sites[indexPath.row].getImage()
        }
        
        return siteCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastIndexClicked = indexPath
        showInfoItem(site: sites[indexPath.row])
    }

}
