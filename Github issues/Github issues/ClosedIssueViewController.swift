//
//  ClosedIssueViewController.swift
//  Github issues
//
//  Created by Manaswini Aitha on 22/01/23.
//

import UIKit

class ClosedIssueViewController: UITableViewController {
    var issuesGit = [GitHubClient.GithubIssue]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Closed issues"
        // code to add refresh functionality
        let refreshControl = UIRefreshControl()
        let title = NSAttributedString(string: "Pull to Refresh")
        refreshControl.attributedTitle = title
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        self.tableView.refreshControl = refreshControl


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        GitHubClient.fetchIssues(state: "closed"){ (issues, error) in
          // Ensure we have good data before anything else
            guard let issues = issues, error == nil else {
                if let error = error{
                    print(error )
                }
                return
            }
        self.issuesGit = issues
        self.tableView.reloadData()
        }
    }

    @objc func refresh(sender: UIRefreshControl) {
        print("done refreshing")
        GitHubClient.fetchIssues(state: "closed"){ (issues, error) in
            
            // Ensure we have good data before anything else
            guard let issues = issues, error == nil else {
                if let error = error{
                    print(error )
                }
                return
            }
            self.issuesGit = issues
            self.tableView.reloadData()
            sender.endRefreshing()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.issuesGit.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IssueTableViewCell
        // Configure the cell...
        cell.title?.text = issuesGit[indexPath.row].title
        cell.issueImage?.image = UIImage(named: "checkmark.png")
        //print(issuesGit[indexPath.row][1])
        cell.userName?.text = "@\(issuesGit[indexPath.row].user.login)"
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "closedIssue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let newC = segue.destination as! IssueDetailViewController
                let selectedIssue = self.issuesGit[indexPath.row]
                newC.returnbody = selectedIssue
            }
        }
    }
    

}
