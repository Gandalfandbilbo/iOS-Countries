//
//  ViewController.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/18/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//
//Check for search bar does not work properly
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate
{
    @IBAction func video(_ sender: Any)
    {
        performSegue(withIdentifier: "video", sender: Any.self)
    }
    @IBAction func quiz(_ sender: Any)
    {
        performSegue(withIdentifier: "quiz", sender: Any.self)
    }
    var countrieslist = [Countries]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filtercountries = [Countries]()
    var searchstatus : Bool = false
    override func viewDidDisappear(_ animated: Bool)
    {
            self.clear()
			self.tableview.reloadData()
    }
    func clear()
    {
        self.searchBar.text=""
        self.searchBar.resignFirstResponder()
    }
    override func viewDidLoad()
    {
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        searchBar.setImage(UIImage(), for: .clear, state: .normal)
        
        
        data.getData()
            {
                (result: Array<Countries>) in
                self.countrieslist = result
                self.tableview.reloadData()
            }
        super.viewDidLoad()
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchstatus)
        {
            return filtercountries.count;
        }
        return countrieslist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        var country: Countries
        if (searchstatus)
        {
            country = filtercountries[indexPath.row]
        }
        else
        {
            country = countrieslist[indexPath.row]
        }
        cell.textLabel?.text = country.country
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(searchstatus)
        {
            performSegue(withIdentifier: "info", sender: filtercountries[indexPath.row])
        }
        else
        {
            performSegue(withIdentifier: "info", sender: countrieslist[indexPath.row])
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "info"
        {
            let info = segue.destination as! CountryInfo
            info.countryarray = [sender as! Countries]
        }
        else if segue.identifier=="quiz"
        {
            _ = segue.destination as! QuizViewController
        }
        else
        {
            _ = segue.destination as! VideoViewController
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchstatus = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        searchstatus = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchstatus = false;
        self.tableview.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchstatus = false;
    }
    func filtered( _ searchText: String)
    {
        filtercountries = countrieslist.filter({( countries: Countries) -> Bool in
        return countries.country.lowercased().contains(searchText.lowercased())})
        self.tableview.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filtered(searchText)
    }
}

