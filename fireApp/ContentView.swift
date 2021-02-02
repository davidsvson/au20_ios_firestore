//
//  ContentView.swift
//  fireApp
//
//  Created by David Svensson on 2021-02-02.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var db = Firestore.firestore()
    @State private var items = [Item]()
    
    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button(action: {
                            if let id = item.id {
                                db.collection("items").document(id).updateData(["done" : !item.done])
                            }
                        }, label: {
                            Image(systemName: item.done ? "checkmark.square" : "square")
                        })
                    }
                }
            }.onAppear() {
                listenToFirestore()
            }
            Button(action: {
                saveToFirestore()
            }, label: {
                Text("Save")
            })
//            Button(action: {
//                readFromFirestore()
//            }, label: {
//                Text("Load")
//            })
        }
    }
    
    func saveToFirestore() {
        
        let item = Item(name: "morot")
        
        do {
            _ = try db.collection("items").addDocument(from: item)
        } catch {
            print("Print error saving to DB")
        }
        
        //db.collection("tmp").addDocument(data: ["name" : "David"])
    }
        
    func listenToFirestore() {
        db.collection("items").addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Error getting document \(err)")
            } else {
                items.removeAll()
                for document in snapshot!.documents {
                    
                    let result = Result {
                        try document.data(as: Item.self)
                    }
                    switch result {
                    case .success(let item):
                        if let item = item {
                            //print("\(item)")
                            items.append(item)
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        
        
//        db.collection("tmp").getDocuments() { (snapshot, err) in
//            if let err = err {
//                print("Error getting document \(err)")
//            } else {
//                for document in snapshot!.documents {
//                    print("\(document.documentID) : \(document.data())")
//                }
//            }
//        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
