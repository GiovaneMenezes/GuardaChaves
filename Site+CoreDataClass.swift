//
//  Site+CoreDataClass.swift
//  
//
//  Created by Giovane Silva de Menezes Cavalcante on 19/07/2018.
//
//

import UIKit
import CoreData
import Alamofire
import AlamofireImage

public class Site: NSManagedObject {
    func setImage(image:UIImage){
        logo = NSData(data: UIImagePNGRepresentation(image)!)
    }
    
    func getImage() -> UIImage? {
        if self.logo != nil{
            return UIImage(data: Data(referencing: self.logo!))
        } else{
            return nil
        }
    }
}
