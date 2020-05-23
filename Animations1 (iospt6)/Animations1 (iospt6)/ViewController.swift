//
//  ViewController.swift
//  Animations1 (iospt6)
//
//  Created by Bohdan Tkachenko on 5/21/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //config label
        configureLabel()
        //config buttons
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.center = view.center
    }
    
    private func configureLabel() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
        label.text = "🤣"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        view.addSubview(label)
        
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
    }
    
    private func configureButtons() {
        //rotate button
        let rotateButton = UIButton(type: .system)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        //spring button
        let springButton = UIButton(type: .system)
        springButton.translatesAutoresizingMaskIntoConstraints = false
        springButton.setTitle("Spring", for: .normal)
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        //key button
        let keyButton = UIButton(type: .system)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        keyButton.setTitle("Key", for: .normal)
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        //squash button
        let squashButton = UIButton(type: .system)
        squashButton.translatesAutoresizingMaskIntoConstraints = false
        squashButton.setTitle("Squash", for: .normal)
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)
        //anticipation button
        let anticipationButton = UIButton(type: .system)
        anticipationButton.translatesAutoresizingMaskIntoConstraints = false
        anticipationButton.setTitle("Anticipation", for: .normal)
        anticipationButton.addTarget(self, action: #selector(anticipationButtonTapped), for: .touchUpInside)
        // init stack
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        //add butttons to the stack
        stackView.addArrangedSubview(rotateButton)
        stackView.addArrangedSubview(springButton)
        stackView.addArrangedSubview(keyButton)
        stackView.addArrangedSubview(squashButton)
        stackView.addArrangedSubview(anticipationButton)
        
        NSLayoutConstraint.activate(
            [
                //Leading
                stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                //Tralling
                stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                //Bottom
                stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                
            ]
        )
    }
    
    @objc private func rotateButtonTapped() {
        label.center = view.center
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: .pi/4)
        }) { (_) in
            UIView.animate(withDuration: 2.0) {
                self.label.transform = .identity //it takes back to initial state
            }
        }
    }
    
    @objc private func springButtonTapped() {
        label.center = view.center
        
        label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.label.transform = .identity
        },             completion: nil)
    }
    
    @objc private func keyButtonTapped() {
        label.center = view.center
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [], animations: {
            //animation step 1 - init 45 degree rotation
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.label.transform = CGAffineTransform(rotationAngle: .pi/4)
            }
            //animation step 2 - Move the label up
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                self.label.transform = CGAffineTransform(translationX: 0, y: -50)
            }
            // animatiom step 3- move back to identity
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.label.transform = .identity
            }
        }, completion: nil)
    }
    
    @objc private func squashButtonTapped() {
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        
        let animationBlock = {
            //drop
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.label.center = self.view.center
            }
            //squash
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            }
            //Strach
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7) //scale- changes the size
            }
            //returning from strach
            UIView.addKeyframe(withRelativeStartTime: 0.7,
                               relativeDuration: 0.15) {
                                self.label.transform = CGAffineTransform(scaleX: 1.1, y: 0.9) //translation- moves towords orgen
            }
            //Finish
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.label.transform = .identity
            }
        }
        UIView.animateKeyframes(withDuration: 1.5,
                                delay: 0,
                                options: [],
                                animations: animationBlock,
                                completion: nil)
    }
    
    @objc private func anticipationButtonTapped() {
        label.center = view.center
        
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.label.transform = CGAffineTransform(rotationAngle: .pi/16.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(rotationAngle: -.pi/16.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.label.center = CGPoint(x: self.view.bounds.size.width + self.label.bounds.size.width, y: self.view.center.y)
            }
        }
        UIView.animateKeyframes(withDuration: 1.5,
                                delay: 0,
                                options: [],
                                animations: animationBlock,
                                completion: nil)
    }
}

