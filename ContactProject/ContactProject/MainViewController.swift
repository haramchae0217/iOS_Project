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
        Contact.contactList.filteredName = Contact.contactList.name
        
        let sortedName = Contact.contactList.filteredName.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.contactList.filteredName = sortedName
        
        tableView.reloadData()
    }
    @IBAction func addContactButtonClicked(_ sender: UIBarButtonItem) {
        guard let addContactVC = self.storyboard?.instantiateViewController(withIdentifier: "addContactVC") as? AddContactViewController else { return }
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    @IBAction func groupContactButtonClicked(_ sender: UIBarButtonItem) {
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "⚠️", message: "다시 확인 후 검색하세요.", preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(doneButton)
        present(alert, animated: true, completion: nil)
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        if !Contact.contactList.filteredName.isEmpty{
            cell.contactNameLabel.text = Contact.contactList.filteredName[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Contact.contactList.filteredName.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Contact.contactList.filteredName.remove(at: indexPath.row)
            Contact.contactList.name.remove(at: indexPath.row)
            Contact.contactList.phoneNumber.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        editVC.editName = Contact.contactList.name
        editVC.editPhoneNumber = Contact.contactList.phoneNumber
        editVC.editFilteredName = Contact.contactList.filteredName
        editVC.addOrEdit = true
        self.navigationController?.pushViewController(editVC, animated: true)
        
    }
}

extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating,
UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let name = searchController.searchBar.text {
            Contact.contactList.filteredName = Contact.contactList.name.filter{ $0.lowercased().contains(name)}
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let sortedName = Contact.contactList.filteredName.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.contactList.filteredName = sortedName
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Contact.contactList.filteredName = Contact.contactList.name
        let sortedName = Contact.contactList.filteredName.sorted { lhs, rhs in
            lhs < rhs
        }
        Contact.contactList.filteredName = sortedName
        tableView.reloadData()
    }
}
