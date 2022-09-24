//
//  RegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Arthur Martinez on 9/23/22.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    var registrations: [Registration] = []
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView,
       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "RegistrationCell", for: indexPath)
    
        let registration = registrations[indexPath.row]
        print(registration)
        var content = cell.defaultContentConfiguration()
        content.text = registration.firstName + " " + registration.lastName
        content.secondaryText = (registration.checkInDate..<registration.checkOutDate).formatted(date: .numeric, time: .omitted) + "     " + registration.roomType.name
        cell.contentConfiguration = content
        return cell
    }

    @IBAction func unwindFromAddRegistration(unwindSegue:
       UIStoryboardSegue) {
    
        guard let addRegistrationTableViewController =
           unwindSegue.source as? AddRegistrationTableViewController,
        let registration =
           addRegistrationTableViewController.registration else
           { return }
        registrations.append(registration)
        tableView.reloadData()
    }

}
