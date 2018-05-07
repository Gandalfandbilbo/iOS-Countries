//
//  data.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/18/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import Foundation

class data
{
    class func getData(completion:@escaping (Array<Countries>) -> ())
    {
        
        var fetchCountry = [Countries]()
        
        let url = "https://restcountries.eu/rest/v2/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if (error != nil)
            {
                print("error")
            }
            else
            {
                do
                {
                    let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    var currencies: String?
                    for eachFetchedCountry in fetchData
                    {
                        let eachCountry = eachFetchedCountry as![String : Any]
                        guard let area = eachCountry["area"] as? Double else
                        {
                            continue
                        }
                        let latlng = eachCountry["latlng"] as! [Double]
                        let latitude = latlng[0]
                        let longitude = latlng[1]
                        let continent = eachCountry["region"] as! String
                        let co = eachCountry["name"] as! String
                        let ca = eachCountry["capital"] as! String
                        let currency = eachCountry["currencies"] as! [[String: AnyObject]]
                        
                        for eachCurrency in currency
                        {
                            if let c = eachCurrency["name"] as? String
                            {
                                currencies = c
                            }
                            else {currencies = "Not Found"}
                        }
                        let population = eachCountry["population"] as! Double
                        let flagcode = eachCountry["alpha2Code"] as! String
                        fetchCountry.append(Countries(country: co, capital: ca, continent: continent,latitude: latitude, longitude: longitude,area: area, currency: currencies!,population: population,flagcode:flagcode))
                    }
                    completion(fetchCountry)
                }
                catch
                {
                    print("Error in data fetch")
                }
            }
        }
        task.resume()
    }

}
