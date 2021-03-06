//
//  popOverViewController.swift
//  Todo
//
//  Created by woong on 02/05/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    // MARK: - Variables and Properties
    var emojiDelegate: PopoverDelegate?
    var emojiList: [[String]] = []
    let sectionTitle: [String] = ["Emoticons", "Dingbats", "Transport and map symbols", "Enclosed Characters"]
    let cellId = "emojiCell"
    let addTodoVC = "addTodoViewController"
    
    
    // MARK: - Actions
    @IBAction func emojiTapped(_ sender: Any) {
        print("emojiTapped")
        guard let emojiButton = sender as? UIButton else {
            return
        }

        if let image = emojiButton.currentImage {
            emojiDelegate?.setButtonImage(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmojis()
        
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: self.view.bounds.width, height: 300)
    }
    
    // MARK: - Helper functions
    func fetchEmojis(){
        let emojiRanges = [
            0x1F601...0x1F64F,
            0x2702...0x27B0,
            0x1F680...0x1F6C0,
            0x1F170...0x1F251
        ]
        
        for range in emojiRanges {
            var array: [String] = []
            for i in range {
                if let unicodeScalar = UnicodeScalar(i){
                    array.append(String(describing: unicodeScalar))
                }
            }
            
            emojiList.append(array)
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

// MARK: - extension popOverViewController

extension PopoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        guard let cell: EmojiCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? EmojiCollectionViewCell else {return defaultCell}
        
        cell.emojiButton.setImage(emojiList[indexPath.section][indexPath.item].image(), for: .normal)
        
        return cell
    }
}

extension PopoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
