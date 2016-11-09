//
//  CoursesTableViewController.swift
//  MSSE652
//
//  Created by Mark Evans on 11/6/16.
//  Copyright © 2016 Mark Evans. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    var selectedProgram = Program()
    var courses = [Course]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nsurlSession()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func nsurlSession() {
        let requestURL: NSURL = NSURL(string: "http://www.ccis.site/Regis2/Courses?programId=\(selectedProgram.id)")!
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("200 OK")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String: AnyObject]
                    print(json)
                    
                    if let courses = json["courses"] as? [[String: AnyObject]] {
                        print(courses)
                        
                        for course in courses {
                            if let id = course["id"] as? String {
                                if let name = course["name"] as? String {
                                    print(id, name)
                                    let acourse = Course()
                                    acourse.id = Int(id)!
                                    acourse.name = name
                                    self.courses.append(acourse)
                                }
                            }
                        }
                    }
                } catch {
                    print("Error with JSON: \(error)")
                }
                
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
        task.resume()
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
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
