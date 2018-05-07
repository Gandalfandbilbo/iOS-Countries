//
//  QuizHistory.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/23/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import UIKit

class QuizHistory: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    var data = [UserHistory]()
    @IBOutlet weak var scoreHistory: UITableView!
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad()
    {
        fetchUserHistory()
        scoreHistory.delegate = self
        scoreHistory.dataSource = self
        super.viewDidLoad()
    }
    func fetchUserHistory()
    {
        do
        {
            data = try context.fetch(UserHistory.fetchRequest())
        }
        catch
        {
            print("some error")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let userData = data[indexPath.row]
        cell.textLabel?.text = "Your Score: \(userData.points) Date: " + userData.date! + " Type: " + userData.type!
        return cell
    }
}
