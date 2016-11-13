//
//  ProgramsTableTableViewController.swift
//  MSSE652
//
//  Created by Mark Evans on 10/27/16.
//  Copyright © 2016 Mark Evans. All rights reserved.
//

import UIKit
import Alamofire

class ProgramsTableTableViewController: UITableViewController {

    var programs = [Program]()
    var selectedProgram: Program = Program()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processRequest()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func processRequest() {
        Alamofire
            .request("http://www.ccis.site/Regis2/Programs")
            .responseJSON {
                response in
            
                if let value = response.result.value {
                    print("JSON: \(value)")
                
                    let dictionary = value as! NSDictionary
                    print("DICT: \(dictionary)")
                
                    let programs = dictionary["programs"] as! NSArray
                    print("PROGRAMS: \(programs)")
                
                    for program in programs as! [Dictionary<String, AnyObject>] {
                        let name = program["name"] as! String
                        let id = program["id"] as! String
                        let aprogram = Program()
                        aprogram.id = Int(id)!
                        aprogram.name = name
                        self.programs.append(aprogram)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
          
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return programs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath)
        cell.textLabel?.text = programs[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Entering didSelectRowAtIndexPath row \(indexPath.row)")
        selectedProgram = programs[indexPath.row]
        NSLog("selectedProgram: \(selectedProgram.toString())")
        performSegue(withIdentifier: "SegueToCourses", sender: self)
        NSLog("exiting didSelectRowAtIndexPath row #\(indexPath.row)!")
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("entering prepareForSegue")
        
        if segue.identifier == "SegueToCourses" {
            NSLog("SegueToCourses")
            
            let destination = segue.destination as? CoursesTableViewController
            
            destination?.selectedProgram = selectedProgram
            
            NSLog("selectedProgram: \(selectedProgram.toString())")
            NSLog("selectedProgram: \(destination?.selectedProgram.toString())")
        }
        NSLog("exiting prepareForSegue")
    }
 

}
