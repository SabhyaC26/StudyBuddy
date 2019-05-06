//
//  ViewController.swift
//  yay2
//
//  Created by Lillian Joyce and Twesha Modi on 4/16/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import UIKit

protocol ChangeViewControllerClassListDelegate: class {
    func addClass(to additionalClass: YourClasses)
}

class ViewController: UIViewController{

    var addClass: UIButton!
    var presentModalViewControllerButton: UIButton!
    let padding: CGFloat = 20
    let classReuseIdentifier: String = "ClassCollectionViewCell"
    
    var classCollectionView: UICollectionView!
    
    
    var classes: [YourClasses] = []
    var displayClassCollectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Welcome to StudyBuddy"  // Set the navigation controller's title!
        edgesForExtendedLayout = []// gets rid of views going under navigation controller
        
        
        let cs1110 = YourClasses(classname: "Intro to iOS Development")
        let cs2210 = YourClasses(classname: "Intro to Computing Using Python")
        let cs2800 = YourClasses(classname: "Object Oriented Programming")
        let SP = YourClasses(classname: "Systems Programming")
        let IC = YourClasses(classname: "Intro to Collecting Your Data")
        let MLB = YourClasses(classname: "Machine Learning on the Blockchain")
        let M = YourClasses(classname: "Minimalism")
        let DIT = YourClasses(classname: "Download Ithaca Transit, Pollo, Eatery, and Uplift!!")
        
        classes = [cs1110, cs2210, cs2800, SP, IC, MLB, M, DIT]
        
        
        
        addClass = UIButton()
        addClass.translatesAutoresizingMaskIntoConstraints = false
        addClass.setTitle("Click to Add Class", for: .normal)
        addClass.setTitleColor(.black, for: .normal)
        addClass.addTarget(self, action: #selector(pushClassList), for: .touchUpInside)
        view.addSubview(addClass)
        
        presentModalViewControllerButton = UIButton()
        presentModalViewControllerButton.translatesAutoresizingMaskIntoConstraints = false
        presentModalViewControllerButton.setTitle("Your Classes", for: .normal)
        presentModalViewControllerButton.setTitleColor(.black, for: .normal)
        presentModalViewControllerButton.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
        view.addSubview(presentModalViewControllerButton)
        
        let layoutforClassCollectionView = UICollectionViewFlowLayout()
        classCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutforClassCollectionView)
        classCollectionView.translatesAutoresizingMaskIntoConstraints = false
        classCollectionView.dataSource = self
        classCollectionView.delegate = self
        classCollectionView.register(ClassCollectionViewCell.self, forCellWithReuseIdentifier: classReuseIdentifier)
        classCollectionView.showsHorizontalScrollIndicator = false
        classCollectionView.backgroundColor = .clear
        view.addSubview(classCollectionView)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addClass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addClass.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //addClass.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addClass.heightAnchor.constraint(equalToConstant: 24)
            ])
//
        NSLayoutConstraint.activate([
            presentModalViewControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentModalViewControllerButton.topAnchor.constraint(equalTo: addClass.bottomAnchor, constant: 16),
            presentModalViewControllerButton.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            classCollectionView.topAnchor.constraint(equalTo: presentModalViewControllerButton.bottomAnchor, constant: 24),
            classCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            classCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            classCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }

    
    
    @objc func pushClassList() {
        let classListViewController = ClassListViewController()
        navigationController?.pushViewController(classListViewController, animated: true)
    }
    
    @objc func presentModalViewController() {
    }
    
    func addToClassList(){
        
    }
}
extension ViewController: UICollectionViewDataSource{
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: classReuseIdentifier, for: indexPath) as? ClassCollectionViewCell else { return UICollectionViewCell() }
        let thisClass = classes[indexPath.item]
        cell.setup(withClass: thisClass)
        return cell
    }
    }
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //push info that specific class
        
        //idk how to do this?
    }
    
    }
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = collectionView.frame.width - 1.5*padding
        return CGSize(width: length, height: 40)
    }
}

//extension ViewController: ChangeViewControllerClassListDelegate{
  //  func
//}



