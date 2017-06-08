//
//  ViewController+layout.swift
//  Audio Recording
//
//  Created by Jin Kato on 6/7/17.
//  Copyright © 2017 Jin Kato. All rights reserved.
//

import UIKit

extension ViewController {
    
    func layoutRecordButton(){
        view.addSubview(recordButton)
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func layoutPlayButton(){
        view.addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 20).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
