//
//  CollectionViewController.swift
//  ch3-simple-collection-view
//
//  Created by regan on 28/02/2017.
//  Copyright © 2017 Heng-Hao. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // An Array of Dictionaries in a property in ViewController
    var suitsArray = [Dictionary<String, AnyObject>]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Get into good habits around handling errors
    // The source JSON might not exist, and it might prove impossible to parse.
    // In either of those situations, you need to handle the resulting errors.
    enum ParsingError: Error {
        case MissingJson
        case JsonParsingError
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Configure data
        setupData()
        
        // Configure collection view
        configureCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return suitsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cardsDictionary = self.suitsArray[section]
        let cardsArray = cardsDictionary["cards"] as! NSArray
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        let suitDictionary = suitsArray[indexPath.section]
        let cardsArray = suitDictionary["cards"] as! [Dictionary<String, AnyObject>]
        let cardDictionary = cardsArray[indexPath.row]
        
        let cardImageName = cardDictionary["cardImage"] as! String
        if let cardImage = UIImage(named: cardImageName) {
            
            if let imageView = cell.contentView.viewWithTag(1000) as? UIImageView {
                imageView.image = cardImage
            }
        }
        
        return cell
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
    }
    
    func setupData() {
        let file = Bundle.main.path(forResource: "cards", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: file!))
        let parsedObject = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
        suitsArray = parsedObject?["suits"] as! Array
    }
}

