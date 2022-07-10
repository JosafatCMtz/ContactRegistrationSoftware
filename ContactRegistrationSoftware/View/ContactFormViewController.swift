//
//  ContactFormViewController.swift
//  ContactRegistrationSoftware
//
//  Created by Josafat Martínez  on 09/07/22.
//

import UIKit

class ContactFormViewController: UIViewController {
    
    // MARK: @IBOulets
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var conatctNameValidationLabel: UILabel!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var contactNumberValidationLabel: UILabel!
    @IBOutlet weak var conatctEmailTextField: UITextField!
    @IBOutlet weak var contactEmailValidationText: UILabel!
    @IBOutlet weak var contactAddressTextField: UITextField!
    @IBOutlet weak var contactNotesTextField: UITextField!
    @IBOutlet weak var saveContactButton: UIButton!
    
    private var viewModel: ContactFormViewModel = ContactFormViewModel()
    private var router: Router = Router()
    
    
    public var editableContact: Contact?
    public var isEditingContact: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bind(to: self, withRouter: router)
        let textFields: [UITextField] = [contactNameTextField, contactNumberTextField, conatctEmailTextField, contactAddressTextField, contactNotesTextField]
        self.addDelegateToFields(textFields)
        guard let editableContact = editableContact else {
            return
        }
        self.updateTextFieldWith(editableContact)
    }
    
    private func updateTextFieldWith(_ contact: Contact) {
        contactNameTextField.text = contact.name
        contactNumberTextField.text = contact.phoneNumber
        conatctEmailTextField.text = contact.email
        contactAddressTextField.text = contact.address
        contactNotesTextField.text = contact.notes
    }
    
    private func addDelegateToFields(_ textFields: [UITextField]) {
        textFields.forEach { textField in
            textField.delegate = self
        }
    }
    
    
    fileprivate func validateTextFields(_ requiredTextFields: [UITextField], _ errorMessagesLabels: [UILabel]) -> Bool {
        var isValid: Bool = true
        requiredTextFields.forEach { textField in
            guard let indexOftextField = requiredTextFields.firstIndex(of: textField) else { return }
            if textField.isEmpty {
                textField.isRequired(messageLabel: errorMessagesLabels[indexOftextField])
                isValid = false
            } else {
                errorMessagesLabels[indexOftextField].isHidden = true
            }
        }
        return isValid
    }
    
    @IBAction func saveContact() {
        let requiredTextFields: [UITextField] = [contactNameTextField, contactNumberTextField, conatctEmailTextField]
        let errorMessagesLabels: [UILabel] = [conatctNameValidationLabel, contactNumberValidationLabel, contactEmailValidationText]
        if validateTextFields(requiredTextFields, errorMessagesLabels) {
            let newContact: Contact = .init(name: contactNameTextField.text!,
                                            phoneNumber: contactNumberTextField.text!,
                                            email: conatctEmailTextField.text!,
                                            address: contactAddressTextField.text ?? "",
                                            notes: contactNotesTextField.text ?? "")
            if isEditingContact {
                self.viewModel.editContact(newContact) { result in
                    switch result {
                    case .success(let isEditing):
                        if isEditing {
                            self.navigationController?.pushViewController(MenuViewController(), animated: true)
                        }
                    default:
                        break
                    }
                }
            } else {
                self.viewModel.addContact(newContact) { result in
                    switch result {
                    case .success(let isAdded):
                        if isAdded {
                            self.navigationController?.pushViewController(MenuViewController(), animated: true)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
}

extension ContactFormViewController: UITextFieldDelegate {}

extension UITextField {
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
            return false
        }
        return true
    }
    
    func isRequired(messageLabel: UILabel) {
        messageLabel.isHidden = !self.isEmpty
    }
}
