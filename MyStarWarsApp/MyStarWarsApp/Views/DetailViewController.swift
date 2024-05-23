//
//  DetailViewController.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import UIKit

class DetailViewController: UIViewController {

    var person: Person?
    var species: Species?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        if let person = person {
            title = person.name

            let nameLabel = UILabel()
            nameLabel.text = "Name: \(person.name)"
            nameLabel.translatesAutoresizingMaskIntoConstraints = false

            let heightLabel = UILabel()
            heightLabel.text = "Height: \(person.height)"
            heightLabel.translatesAutoresizingMaskIntoConstraints = false

            let massLabel = UILabel()
            massLabel.text = "Mass: \(person.mass)"
            massLabel.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(nameLabel)
            view.addSubview(heightLabel)
            view.addSubview(massLabel)

            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                massLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20),
                massLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        } else if let species = species {
            title = species.name

            let nameLabel = UILabel()
            nameLabel.text = "Name: \(species.name)"
            nameLabel.translatesAutoresizingMaskIntoConstraints = false

            let classificationLabel = UILabel()
            classificationLabel.text = "Classification: \(species.classification)"
            classificationLabel.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(nameLabel)
            view.addSubview(classificationLabel)

            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                classificationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                classificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        }
    }
}

