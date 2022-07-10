//
//  ContactsViewModel.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import Foundation
import UIKit

class ContactsViewModel{
    
    private(set) weak var view: ContactsViewController?
    private var router: Router?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    enum ContactsError: Error {
        case emptyList
    }
    
    
    func bind(to view: ContactsViewController, withRouter router: Router) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func fetchAllContacts(completion: @escaping (Result<Contacts, ContactsError>)->() ){
        let contacts: Contacts = appDelegate.contacts
        if contacts.isEmpty {
            completion(.failure(.emptyList))
        } else {
            completion(.success(contacts))
        }
    }
    
    
}
