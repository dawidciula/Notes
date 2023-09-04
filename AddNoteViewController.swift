//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Dawid Ciuła on 03/09/2023.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    
    @IBOutlet weak var ContentTextField: UITextField!
    @IBOutlet weak var TitleTextField: UITextField!
    
    @IBAction func AddNoteButton(_ sender: UIButton) {
        if let title = TitleTextField.text, let content = ContentTextField.text {
                saveNote(title, content)
            } else {
                print("")
            }
    }
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if container == nil {
            container = NSPersistentContainer(name: "Notes")
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error {
                    fatalError("Nie udało się załadować magazynu: \(error)")
                }
            }
            
            // Do any additional setup after loading the view.
        }
    }
    
        func saveNote(_ title: String, _ content: String) -> Void
        {
            let saveNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: container.viewContext) as! Note
            saveNote.title = title
            saveNote.content = content
            do
            {
                try container.viewContext.save()
                print(title)
                print(content)
            } catch {
                print("Nie udało się zapisać notatki: ", error)
            }
            
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

