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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveContact() {
        print("saveContact")
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
}
