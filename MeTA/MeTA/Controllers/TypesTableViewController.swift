//
//  TypesTableViewController.swift
//  MeTA
//
//  Created by Kevin J. Zheng on 2/29/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit

protocol TypesTableViewControllerDelegate: class {
  func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String])
}

class TypesTableViewController: UITableViewController {
  
  private let possibleTypesDictionary = ["train": "Train", "bus": "Bus"]
  private var sortedKeys: [String] {
    return possibleTypesDictionary.keys.sorted()
  }
  
  weak var delegate: TypesTableViewControllerDelegate?
  var selectedTypes: [String] = []
  
  
  // MARK: - Actions
  @IBAction func donePressed(_ sender: AnyObject) {
    delegate?.typesController(self, didSelectTypes: selectedTypes)
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return possibleTypesDictionary.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
    let key = sortedKeys[indexPath.row]
    let type = possibleTypesDictionary[key]
    cell.textLabel?.text = type
    cell.imageView?.image = UIImage(named: key)
    cell.accessoryType = selectedTypes.contains(key) ? .checkmark : .none
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let key = sortedKeys[indexPath.row]
    if selectedTypes.contains(key) {
      selectedTypes = selectedTypes.filter({$0 != key})
    } else {
      selectedTypes.append(key)
    }
    
    tableView.reloadData()
  }
}
