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
    @IBOutlet weak var eventButton: UIView!
    @IBOutlet weak var createEventButton: UIView!
    
    let realm = try! Realm()
    
    let viewModel = EventViewModel()
    var events : [Events] = []
    var searchData : [Events] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.register(EventTableViewCell.nib(), forCellReuseIdentifier: EventTableViewCell.identifier)
        setupUI()
        
        let createEventButtonGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createEventButtonClicked))
        self.createEventButton.isUserInteractionEnabled = true
        self.createEventButton.addGestureRecognizer(createEventButtonGesture)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.events = self.viewModel.getEvents()
            self.searchData = self.events
            self.eventTableView.reloadData()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemPurple
        eventTableView.separatorStyle = .none
        
        backView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 50)
        eventButton.roundedCorners()
        createEventButton.roundedCorners()
        searchBar.addColoredBottomBorder(color: .systemGray)
        searchBar.layer.cornerRadius = 50
    }
    
    @objc func createEventButtonClicked() {
        performSegue(withIdentifier: "segue", sender: nil)
    }
}

extension EventViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath)
                as? EventTableViewCell else {
                    return UITableViewCell()
                }
        let data = searchData[indexPath.row]
        cell.configure(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            realm.beginWrite()
            
            let realmdb = realm.objects(Events.self)
            realmdb.forEach { x in
                if x.companyName?.uppercased() == searchData[indexPath.row].companyName?.uppercased() {
                    realm.delete(x)
                }
            }
            self.eventTableView.reloadData()
            try! realm.commitWrite()
            self.searchData.remove(at: indexPath.row)
            self.eventTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension EventViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = []
        if searchText == "" {
            searchData = events
        }
        for word in events {
            if word.companyName!.uppercased().contains(searchText.uppercased()) {
                searchData.append(word)
            }
        }
        self.eventTableView.reloadData()
    }
}


