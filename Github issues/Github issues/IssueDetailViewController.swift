//
//  IssueDetailViewController.swift
//  Github issues
//
//  Created by Manaswini Aitha on 22/01/23.
//

import UIKit

class IssueDetailViewController: UIViewController {
    // Attribution: https://www.codingem.com/swift-how-to-initialize-a-struct/ - initialising a struct
    // Attribution: https://stackoverflow.com/questions/67169665/swift-multi-dimensional-structure-organization-and-init - initialising a multi-dimensioanl struct
    var returnbody = GitHubClient.GithubIssue(title: "", createdAt:"", body :"",state:"", user: GitHubClient.GitHubUser(login: "") )
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Attribution: https://stackoverflow.com/questions/36861732/convert-string-to-date-in-swift
        // Attribution: https://cocoacasts.com/swift-fundamentals-how-to-convert-a-date-to-a-string-in-swift
        // Atttribution: https://stackoverflow.com/questions/35700281/date-format-in-swift#:~:text=Year%3A%20y%20(2018)%2C,Day%20of%20month%3A%20d%2C%20dd - date formats available in swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let newDate = dateFormatter.date(from: returnbody.createdAt)
        dateFormatter.dateFormat = "MMMM d,yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        let finalDate = dateFormatter.string(from: newDate ?? Date())
        issueBody.text = returnbody.body
        issueTitle.text = returnbody.title
        date.text = finalDate
        issueUserName.text = "@\(returnbody.user.login)"
        if returnbody.state == "open"{
            issueState.image = UIImage(named: "mailbox.jpg")
        }
        else if returnbody.state == "closed"{
            issueState.image = UIImage(named: "checkmark.png")
        }
        
    }
    

    @IBOutlet weak var issueState: UIImageView!
    @IBOutlet weak var issueBody: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var issueUserName: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        }
     */
    }
    

