//
//  ViewController.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let heightForRow: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let searchContact = UISearchController(searchResultsController: nil)
        searchContact.searchResultsUpdater = self
        searchContact.searchBar.delegate = self
        searchContact.searchBar.placeholder = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchContact
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Contact.filteredName = Contact.name
    
        let sortedName = Contact.name.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.name = sortedName
        
        let sortedPhoneNumber = Contact.contactList.sorted { lhs, rhs in
            lhs.phoneNumber < rhs.phoneNumber
        }
        Contact.contactList = sortedPhoneNumber
        
        let sortedFilteredName = Contact.filteredName.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.filteredName = sortedFilteredName
        
        tableView.reloadData()
    }
    @IBAction func addContactButtonClicked(_ sender: UIBarButtonItem) {
        guard let addContactVC = self.storyboard?.instantiateViewController(withIdentifier: "addContactVC") as? AddContactViewController else { return }
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    @IBAction func groupContactButtonClicked(_ sender: UIBarButtonItem) {
        
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        if !Contact.filteredName.isEmpty {
            cell.contactNameLabel.text = Contact.filteredName[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Contact.filteredName.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert()
        }
        
        func showAlert() {
            let alert = UIAlertController(title: "⚠️", message: "정말 삭제하시겠습니까?" , preferredStyle: .alert)
            let doneButton = UIAlertAction(title: "확인", style: .destructive) { _ in
                Contact.name.remove(at: indexPath.row)
                Contact.filteredName.remove(at: indexPath.row)
                Contact.contactList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            let cancelButton = UIAlertAction(title: "취소", style: .default)
            alert.addAction(cancelButton)
            alert.addAction(doneButton)
            present(alert, animated: true, completion: nil)
            
        }
         
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editVC = storyboard?.instantiateViewController(withIdentifier: "addContactVC") as? AddContactViewController else { return }
        editVC.editRow = indexPath.row
        editVC.editName = Contact.name[indexPath.row]
        editVC.editFilteredName = Contact.filteredName[indexPath.row]
        editVC.editContact = Contact.contactList[indexPath.row]
        editVC.addOrEdit = true
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating,
UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let name = searchController.searchBar.text {
            Contact.filteredName = Contact.name.filter{ $0.lowercased().contains(name)}
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let sortedFilteredName = Contact.filteredName.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.filteredName = sortedFilteredName
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Contact.filteredName = Contact.name
        tableView.reloadData()
    }
}
