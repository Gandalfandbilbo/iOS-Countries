//
//  VideoViewController.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/24/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController
{
    @IBOutlet weak var videoView: UIWebView!
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        videoView.allowsInlineMediaPlayback = true
        videoView.loadHTMLString("<iframe width=\"360\" height=\"600\" src=\"https://www.youtube.com/embed/xUuoFch3ArM\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
