//
//  ViewController.swift
//  Countries
//
//  Created by Roy Orpiano on 11/8/21.
//

import UIKit

let cellIdentifier = "cell"
class CountryTableViewCell: UITableViewCell {
    
}

class CountryViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var countries:[Country] = [Country]()
    let viewModel = CountriesViewModel()
    var searching:Bool = false
    var searchedCountry:[Country] = [Country]()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        self.activityIndicator.startAnimating()
        
        /* Added refresh control. To fetch data when a connection problem was encountered */
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.fecthData(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.fecthData(self)
    }
    
    @objc func fecthData(_ sender: AnyObject) {
        viewModel.getAllCountries { result in
            self.activityIndicator.isHidden = true
            self.refreshControl.endRefreshing()
            
            switch result {
            case .success(let countries):
                self.countries = countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error: ", error.localizedDescription)
                
                let alert = UIAlertController(title: "Problem connecting to the server.", message: "Check your internet connection.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}

extension CountryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return self.searchedCountry.count
        } else {
            return self.countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
        
        var country:Country
        
        if searching {
            country = self.searchedCountry[indexPath.row]
        } else {
            country = self.countries[indexPath.row]
        }
        
        cell.textLabel?.text = country.name
        
        return cell
    }
}

extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDetailView:CountryDetail = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetail") as! CountryDetail
        
        var country:Country
        
        if searching {
            country = self.searchedCountry[indexPath.row]
        } else {
            country = self.countries[indexPath.row]
        }
        countryDetailView.name = country.name;
        countryDetailView.imageURLString = country.flags.png
        
        countryDetailView.capital = ""
        if let capital = country.capital {
            countryDetailView.capital = capital
        }
        
        countryDetailView.currency = ""
        if let currencies = country.currencies {
            var string = ""
            for currency in currencies {
                string = String("\(string), \(currency.name)")
            }
            
            countryDetailView.currency = string.replacingFirstOccurrence(of: ",", with: "")
        }
        
        countryDetailView.languages = ""
        if let languages = country.languages {
            var string = ""
            for language in languages {
                string = String("\(string), \(language.name!)")
            }
            
            countryDetailView.languages = string.replacingFirstOccurrence(of: ",", with: "")
        }

        self.navigationController?.pushViewController(countryDetailView, animated: true)
    }
}

extension String {

    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}

extension CountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedCountry = self.countries.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        self.searching = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        self.searchBar.text = ""
        self.tableView.reloadData()
    }
    
}


