//
//  CountryInfo.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/19/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import UIKit
import CoreImage

class CountryInfo: UIViewController
{
    var mapdata: String?
    @IBAction func mapview(_ sender: Any)
    {
        performSegue(withIdentifier: "map", sender: mapdata)
    }
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var continent: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var abb: UILabel!
    @IBAction func backk(_ sender: Any)
    {
       dismiss(animated: true, completion: nil)
    }
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var flag: UIImageView!
    var imgcode: String?
    var countryarray = [Countries]()
    
    override func viewDidLoad()
    {
        var path: String?
        for eachdata in countryarray
        {
            imgcode = eachdata.flagcode.lowercased()
            if let p: String = Bundle.main.path(forResource: imgcode, ofType: "png", inDirectory: "png1000px/")
            { path = p }
            else
            { path = Bundle.main.path(forResource: "default", ofType: "png", inDirectory: "png1000px/") }
            let imageFromPath = UIImage(contentsOfFile: path!)!
            self.flag.image = imageFromPath
            self.country.text = eachdata.country
            if (eachdata.capital == "")
            {
                self.capital.text = "No Capital"
            }
            else
            {
                self.capital.text = eachdata.capital
            }
            self.continent.text = eachdata.continent
            self.population.text = "\(eachdata.population)"
            self.area.text = "\(eachdata.area)"
            self.currency.text = eachdata.currency
            self.abb.text = eachdata.flagcode
            super.viewDidLoad()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            for eachdata in countryarray
            {
                mapdata = eachdata.country
                let lat = eachdata.latitude
                let lon = eachdata.longitude
                let info = segue.destination as! MapView
                info.country = mapdata
                info.latitude = lat
                info.longitude = lon
            }
    }
}
