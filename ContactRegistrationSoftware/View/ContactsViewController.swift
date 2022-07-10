//
//  ContactsViewController.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    private var viewModel: ContactsViewModel = ContactsViewModel()
    private var router: Router = Router()
    private var identifier: String = String(describing: ContactsTableViewCell.self)
    private var contacts: Contacts? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.viewModel.bind(to: self, withRouter: router)
        self.setUpTableView()
        self.fetchAllContacts()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.contactTableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        let nibName: String = String(describing: ContactsTableViewCell.self)
        let bundle: Bundle? = nil
        let nib: UINib = UINib(nibName: nibName, bundle: bundle)
        contactTableView.register(nib, forCellReuseIdentifier: identifier)
        contactTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func emptyAlert() {
        let dialogMessage = UIAlertController(title: "No TienesContactos", message: "Deseas Agregar un contacto nuevo?", preferredStyle: .alert)
        let bactToMenu = UIAlertAction(title: "Cancelar", style: .destructive, handler: { _ in
            self.navigationController?.pushViewController(MenuViewController(), animated: true)
         })
        let addContact = UIAlertAction(title: "Agregar", style: .default) { _ in
            self.navigationController?.pushViewController(ContactFormViewController(), animated: true)
        }
        dialogMessage.addAction(bactToMenu)
        dialogMessage.addAction(addContact)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func fetchAllContacts(){
        self.viewModel.fetchAllContacts { result in
            switch result {
            case .success(let contacts):
                self.contacts = contacts
            case .failure(let error):
                if error == .emptyList {
                    self.emptyAlert()
                }
            }
            self.reloadTableView()
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contacts = contacts else { return 0 }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contactTableView.dequeueReusableCell(withIdentifier: identifier) as? ContactsTableViewCell else { return UITableViewCell() }
        if let contacts = self.contacts {
            cell.contactNameLabel.text = contacts[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contacts = self.contacts {
            let editableContact = contacts[indexPath.row]
            let viewController: ContactFormViewController = ContactFormViewController()
            viewController.editableContact = editableContact
            viewController.isEditingContact = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
}
