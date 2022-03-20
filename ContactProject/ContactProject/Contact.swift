//
//  Contack.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import Foundation

struct Contact {
    var phoneNumber: [String] = []
    var name: [String] = []
    var filteredName: [String] = []
    static var contactList: Contact = Contact(phoneNumber: [], name: [], filteredName: [])
}
