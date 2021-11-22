//
//  ViewController.swift
//  Newyorktimes
//
//  Created by omair khan on 21/11/2021.
//

import UIKit
import SafariServices

class TopNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var fadingLabel : UILabel = {
         let fadingLabel = UILabel()
         fadingLabel.text = "Text"
         fadingLabel.isHidden = true
         fadingLabel.translatesAutoresizingMaskIntoConstraints = false
        return fadingLabel
    }()
    
   
    private var dataArray = [Results]()
    

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TopNewsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Top Stories"
        
        
        setUpTableView()
        contraints()
        
        
        
        //Check for internet connection
        NetworkMonitor.shared.startMonitoring { [weak self] success in
            if success {
                // Get Top Stories from JSON
                self?.loadJSON()
                
            }else{
                print("Not Connected")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = (navigationController?.view.bounds)!
    }
    
    
    //Constraints for other subviews
    func contraints(){
        
        self.view.addSubview(fadingLabel)
        
        let constraints = [ fadingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
                            fadingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
                            fadingLabel.heightAnchor.constraint(equalToConstant: 100),
                            fadingLabel.widthAnchor.constraint(equalToConstant: 150)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    // TableView setup
    func setUpTableView(){
        /*
         - Add as Subview
         - Set Delegate and Datasoruce
         - Add constraints
         */
        
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)!).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: (self.tabBarController?.tabBar.frame.height)!).isActive = true
    }
    
    //MARK: TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopNewsTableViewCell
        cell.cellData = dataArray[indexPath.row]
        cell.bookMarkBtn.addTarget(self, action: #selector(saveBookMark(_:)), for: .touchUpInside)
        return cell
    }
    
    
    //MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let url = dataArray[indexPath.row].url
        let safari = SFSafariViewController(url: URL(string: url)!)
        self.present(safari, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/8
    }
    
    //MARK:  Load Json Data
    
    func loadJSON()  {
        
        ApiManager.shared.getTopStories { [weak self] result in
            switch result{
            case.success(let topNews):
                self?.dataArray = topNews
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: BookMark Saved
    @objc  func saveBookMark(_ sender : BookMarkButton){
        var dict = ["title" : sender.title!,"imageURL" : sender.imageURL!, "url" : sender.url!]
        DatabaseManager.shared.saveToCoreData(object: dict)
        fadeMessage(message: "Bookmark Saved", color: .lightGray, finalAlpha: 0.0)
    }
    
    
    //MARK: Fade labbel Function
    func fadeMessage(message: String, color: UIColor, finalAlpha: CGFloat) {
        /// Helps to show  messages for users
        fadingLabel.text = message
        fadingLabel.alpha = 1.0
        fadingLabel.isHidden = false
        fadingLabel.textAlignment = .center
        fadingLabel.backgroundColor = color
        fadingLabel.layer.cornerRadius  = 5
        fadingLabel.layer.masksToBounds = true
        fadingLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.fadingLabel.alpha = finalAlpha
        })
    }
}

