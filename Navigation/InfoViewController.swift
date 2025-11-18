//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгения Панфилова on 18.11.2025.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Информация"
        view.backgroundColor = .systemBackground
        
        let button = UIButton(type: .system)
        button.setTitle("Показать алерт", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Заголовок", message: "Это сообщение алерта.", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Да", style: .default) { _ in
            print("Нажата кнопка: Да")
        }
        
        let action2 = UIAlertAction(title: "Нет", style: .cancel) { _ in
            print("Нажата кнопка: Нет")
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert, animated: true)
    }
}
