//
//  AnimalsTableViewController.swift
//  AnimalSpotter
//
//  Created by Ben Gohlke on 4/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AnimalsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "AnimalCell"
    let apiController: APIController = APIController()
    private var animalNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // transition to login view if conditions require
        if apiController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = animalNames[indexPath.row]

        return cell
    }

    // MARK: - Actions
    
    @IBAction func getAnimals(_ sender: UIBarButtonItem) {
        // fetch all animals from API
        //SIMPLE WAY
//        apiController.fetchAllAnimalNames { (result) in
//            if let names = try? result.get() { //LOOK WHAT IT DOES //the method we use throws error
//                DispatchQueue.main.async {
//                    self.animalNames = names
//                    self.tableView.reloadData()
//                }
//            }
//        }
        
        apiController.fetchAllAnimalNames { (result) in
            do {
                let names = try result.get()
                DispatchQueue.main.async {
                    self.animalNames = names
                }
            } catch {
                if let error = error as? APIController.NetworkError {
                    switch error {
                    case .noToken:
                        print("Hav euser try log in againg")
                    case .noData, .tryAgain:
                        print("Have user try again")
                    default:
                        break
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginViewModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.apiController = apiController
            }
        } else if segue.identifier == "ShowAnimalDetailSegue" {
             let detailVC = segue.destination as! AnimalDetailViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.animalName = animalNames[indexPath.row]
                    detailVC.apiController = apiController
                }
            }
        }
    }

