//
//  AddContactViewController.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var addNameTextField: UITextField!
    @IBOutlet weak var addPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "새로운 연락처"
        let doneRightBarButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(addContactBarButton))
        self.navigationItem.rightBarButtonItem = doneRightBarButton
    }
    
    @objc func addContactBarButton() {
        let addName = addNameTextField.text!
        let addPhoneNumber = addPhoneNumberTextField.text!
        let newContact = Contact(name: addName, phoneNumber: addPhoneNumber)
        Contact.contactList.append(newContact)
        self.navigationController?.popViewController(animated: true)
        
    }
    


}
