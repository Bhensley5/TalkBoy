//
//  SoundsTableViewController.swift
//  Talkboy
//
//  Created by zappycode on 7/20/17.
//  Copyright © 2017 Nick Walter. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsTableViewController: UITableViewController {

    var sounds : [Sound] = []
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        getSounds()
    }
    
    func getSounds() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let tempSounds = try? context.fetch(Sound.fetchRequest()) as? [Sound] {
                if let theSounds = tempSounds {
                    sounds = theSounds
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        if let audioData = sound.audioData {
            audioPlayer = try? AVAudioPlayer(data: audioData)
            audioPlayer?.play()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let sound = sounds[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(sound)
                getSounds()
            }
        }
    }
    

}
