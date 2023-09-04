//
//  ViewController.swift
//  Notes
//
//  Created by Dawid Ciuła on 03/09/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var notes: [NSManagedObject] = []  // Zmienione na NSManagedObject, ale możesz użyć klasy Note jeśli jesteś pewny, że ją masz

    // Kontener NSPersistentContainer
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicjalizacja NSPersistentContainer
        container = NSPersistentContainer(name: "Notes")  // Używam "Notes" jako nazwy, ale zastąp to właściwą nazwą Twojego modelu
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Nie udało się załadować magazynu: \(error)")
            }
        }

        // Wczytanie notatek
        fetchNotes()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchNotes() {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Note") // Zakładam, że Twoja encja nazywa się "Note"
        do {
            notes = try container.viewContext.fetch(request)
            tableView.reloadData()
        } catch {
            print("Nie udało się wczytać notatek:", error)
        }
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.value(forKey: "title") as? String // Zakładam, że masz atrybut o nazwie "title" w encji "Note"
        cell.detailTextLabel?.text = note.value(forKey: "content") as? String // Zakładam, że masz atrybut o nazwie "content" w encji "Note"

        return cell
    }
}

