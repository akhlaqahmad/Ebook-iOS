//
//  ViewController.swift
//  Ebook_IOS
//
//  Created by Akhlaq Ahmad on 14/06/2020.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Ouytlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var ebookArray = [EBookModel]()
    
    let popUpDialogue = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
    let popUpView = Bundle.main.loadNibNamed("popUpView", owner: self, options: nil)?.first as! PopUpView
    
    //MARK:- View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        readJOSNData()
        
    }
    
    //MARK:- Private Fucntion.
    
    private func readJOSNData() {
        if let filePath = Bundle.main.path(forResource: "data", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
                let array = json as! Array<Dictionary<String, String>>
                for item in array {
                    let dict = item as Dictionary
                    print(dict)
                    let title = dict["title"]!
                    let cover = dict["cover"]!
                    let object = EBookModel(title: title, cover: cover)
                    self.ebookArray.append(object)
                }
                self.collectionView.reloadData()
            }
            catch {
                //Handle error
            }
        }
    }
    
    func shadowView(btn: UIButton) {
        btn.layer.masksToBounds = false
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowRadius = 1
        btn.layer.shadowOpacity = 0.5
    }
    private func showDescription(sender: Int) {
        popUpView.readBtn.addTarget(self, action: #selector(closeBtn(sender:)), for: .touchUpInside)
        popUpView.shareBtn.addTarget(self, action: #selector(closeBtn(sender:)), for: .touchUpInside)
        popUpView.deleteBtn.addTarget(self, action: #selector(closeBtn(sender:)), for: .touchUpInside)
        shadowView(btn: popUpView.readBtn)
        shadowView(btn: popUpView.shareBtn)
        shadowView(btn: popUpView.deleteBtn)
        popUpDialogue.view.frame = popUpView.frame
        popUpDialogue.view.addSubview(popUpView)
        self.present(popUpDialogue, animated: true, completion: nil)
        let instance = ebookArray[sender]
        popUpView.itemImg.image = UIImage(named: instance.cover)
        popUpView.titleLbl.text = instance.title
    }
    
    
    //MARK:- Actions.
    @objc func closeBtn(sender: UIButton) {
        popUpDialogue.dismiss(animated: true, completion: nil)
    }
    
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ebookArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.itemImg.image = UIImage(named: ebookArray[indexPath.row].cover)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDescription(sender: indexPath.row)
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width) / 2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

