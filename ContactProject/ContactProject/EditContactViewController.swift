//
//  EditContactViewController.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import UIKit

class EditContactViewController: UIViewController {

    @IBOutlet weak var editNameLabel: UITextField!
    @IBOutlet weak var editPhoneNumberLabel: UITextField!
    
    var editContact: Contact?
    var editName: String?
    var editRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRightBarButtonItem()
        
        if let editContact = editContact {
            editPhoneNumberLabel.text = editContact.phoneNumber
            editNameLabel.text = editName
        }
        
        
    }
    func createRightBarButtonItem() {
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(updateButtonClicked))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func updateButtonClicked() {
        
        let editName = editNameLabel.text!
        let editPhoneNumber = editPhoneNumberLabel.text!
        
        guard let contact = editContact else { return }
        if contact.phoneNumber == editPhoneNumber {
            UIAlertController.showAlert(message: "변경 후 다시 시도하세요.", vc: self)
            return
        }
        
        let editContact = Contact(phoneNumber: editPhoneNumber)
        if let editRow = editRow {
            Contact.contactList[editRow] = editContact
            Contact.name[editRow] = editName
        }

        self.navigationController?.popViewController(animated: true)
    }
    
}
