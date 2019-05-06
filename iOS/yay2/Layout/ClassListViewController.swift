//
//  ClassListViewController.swift
//  yay2
//
//  Created by Lillian Joyce on 4/18/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import UIKit
import SnapKit

protocol ifDeleteButtonPressedDelegate: class{
    func deleteClasses(className: String)
}

class ClassListViewController: UIViewController {
    
    //var classes: [YourClasses]!
    var tableView: UITableView!
    var yourCourses: [YourClasses]!
    let reuseIdentifier = "ClassesCellReuse"
    let cellHeight: CGFloat = 50
    
    var courses = [Course]() {
        didSet {
            yourCourses = courses.map { (course) -> YourClasses in
                return YourClasses(classname: course.name)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "All Courses"
        
        //let example = YourClasses(classname: "Class Name Here-- more info can be added")
        //classes = [example, example, example, example]
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(YourClassesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        setupConstraints()
        getClasses()
    }
    
    func setupConstraints() {
        //Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }


    func getClasses(){
        NetworkManager.getClasses { courses in
            self.courses = courses
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}

extension ClassListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = yourCourses[indexPath.row]
        //post method
        //add to your class in collectionview
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    
}

extension ClassListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count //classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! YourClassesTableViewCell
        //let c = classes[indexPath.row]
        let yourCourses = courses.map { (course) -> YourClasses in
            return YourClasses(classname: course.name)
        }
        
        cell.configure(for: yourCourses[indexPath.row])
        return cell
        
        //return UITableViewCell()
    }
    //Number of rows in section and height for row at functions
        
}

extension ClassListViewController: ifDeleteButtonPressedDelegate{
    
    func deleteClasses(className: String){
        NetworkManager.deleteClasses { (courses) in
            self.courses = courses
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}





//extension ViewController: UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("in!")
//        let userinfocontroller = UserInfoViewController()
//        //view.backgroundColor = .blue
//        userinfocontroller.delegate = self
//        //userinfocontroller.index = indexPath.row
//        print("selected")
//        navigationController?.pushViewController(userinfocontroller, animated: true)
//    }
//}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


