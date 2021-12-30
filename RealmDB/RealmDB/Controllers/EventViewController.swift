//
//  ViewController.swift
//  RealmDB
//
//  Created by Ekrem Özkaraca on 29.12.2021.
//

import UIKit
import RealmSwift

class EventViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var eventTableView: UITableView!
    
    let realm = try! Realm()
    
    let viewModel = EventViewModel()
    var events = Events()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.register(EventTableViewCell.nib(), forCellReuseIdentifier: EventTableViewCell.identifier)
        
        events = viewModel.test()
        
    }
}

extension EventViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.companyName?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath)
                as? EventTableViewCell else {
                    return UITableViewCell()
                }
        
        cell.eventNameLabel.text = events.companyName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
}

extension EventViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


