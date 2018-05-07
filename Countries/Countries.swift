//
//  Countries.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/18/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import Foundation

class Countries
{
    let country: String
    let capital: String
    let continent: String
    let latitude: Double
    let longitude: Double
    let area: Double
    let currency: String
    let population: Double
    let flagcode: String
    
    init(country: String, capital: String,continent: String, latitude: Double, longitude: Double,area: Double,currency: String, population: Double,flagcode: String)
    {
        self.country = country
        self.capital = capital
        self.continent = continent
        self.latitude = latitude
        self.longitude = longitude
        self.area = area
        self.currency = currency
        self.population = population
        self.flagcode = flagcode
    }
}
