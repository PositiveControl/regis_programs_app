//
//  FirstViewController.swift
//  MSSE652
//
//  Created by Mark Evans on 10/23/16.
//  Copyright © 2016 Mark Evans. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        NSLog("unwindSegue")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
