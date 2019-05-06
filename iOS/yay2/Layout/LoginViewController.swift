//
//  LoginViewController.swift
//  yay2
//
//  Created by Lillian Joyce on 4/16/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    var textField: UITextField!
    var textField2: UITextField!
    var button: UIButton!
    //var placeholderText: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "login"
        view.backgroundColor = .white
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "username"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = true
        view.addSubview(textField)
        
        textField2 = UITextField()
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.text = "password"
        textField2.borderStyle = .roundedRect
        textField2.backgroundColor = .white
        textField2.textAlignment = .center
        textField2.clearsOnBeginEditing = true
        view.addSubview(textField2)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("login", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(pushNavViewController), for: .touchUpInside)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // textField constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            textField2.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField2.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48)])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func pushNavViewController(){
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }

}
