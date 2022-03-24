//
//  AddContactViewController.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var editContact: Contact?
    var editRow: Int?
    var addOrEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let editContact = editContact {
            phoneTextField.text = editContact.phoneNumber
            nameTextField.text = editContact.name
        }
        if addOrEdit {
            title = "상세화면"
        } else {
            title = "새로운 연락처"
        }
        let doneRightBarButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(addContactBarButton))
        self.navigationItem.rightBarButtonItem = doneRightBarButton
    }
    
    @objc func addContactBarButton() {
        let name = nameTextField.text!
        let phoneNumber = phoneTextField.text!
        let newContact = Contact(name: name, phoneNumber: phoneNumber)
        if addOrEdit {
            if let row = editRow {
                MyDB.contactList[row] = newContact
            }
        } else {
            MyDB.contactList.append(newContact)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "⚠️", message: "변경 후 다시 시도하세요.", preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(doneButton)
        present(alert, animated: true, completion: nil)
    }

}
