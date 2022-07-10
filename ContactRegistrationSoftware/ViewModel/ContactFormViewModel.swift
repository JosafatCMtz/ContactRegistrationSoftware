//
//  ContactFormViewModel.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class ContactFormViewModel {
    
    private(set) weak var view: ContactFormViewController?
    private var router: Router?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    enum ContactsError: Error  {
        case emptyList
        case noContactInList
    }
    
    func bind(to view: ContactFormViewController, withRouter router: Router) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func addContact(_ contact: Contact, completion: @escaping (Result<Bool, ContactsError>)->()) {
        appDelegate.contacts.append(contact)
        let contacts: Contacts = appDelegate.contacts
        if contacts.isEmpty {
            completion(.failure(.emptyList))
        } else {
            completion(.success(true))
        }
    }
    
    func editContact(_ editableContact: Contact, completion: @escaping (Result<Bool, ContactsError>)->()) {
        let exists = appDelegate.contacts.first (where:{ $0.name == editableContact.name })
        if exists != nil {
            appDelegate.contacts.removeAll(where: {$0.name == exists?.name})
            appDelegate.contacts.append(editableContact)
            let contacts: Contacts = appDelegate.contacts
            if contacts.isEmpty {
                completion(.failure(.emptyList))
            } else {
                completion(.success(true))
            }
        }
        completion(.failure(.noContactInList))
    }
}
