//
//  ViewController.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/6.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var resultList: Array<Array<String>> = []
    var animalAry: Array<Array<String>> = [[]]
    var isSearch = false
    var isFilter = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchType1: UILabel!
    @IBOutlet weak var searchType2: UILabel!
    @IBOutlet weak var searchType3: UILabel!
    @IBOutlet weak var searchType4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width-30, height: 180)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        animalAry = animalModel
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(tap:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap(tap: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }

    @IBAction func filterClick(_ sender: UIButton) {
        
        if let filterView = Bundle(for: FilterView.self).loadNibNamed("FilterView", owner: nil, options: nil)?.first as? FilterView {
            filterView.frame = self.view.frame
            filterView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            filterView.alpha = 0
            UIApplication.shared.keyWindow?.addSubview(filterView)
            
            UIView.animate(withDuration: 0.3) {
                filterView.alpha = 1
            }
            
            filterView.setData(data: animalFilter, onSuccess: { (dic) in
                
                let gender = dic["gender"] as! String
                let personality = dic["personality"] as! String
                let animal = dic["animal"] as! String
                let month = dic["month"] as! String
                
                if gender != "全部" {
                    self.searchType1.text = gender
                    self.searchType1.isHidden = false
                } else {
                    self.searchType1.isHidden = true
                }
                if personality != "全部" {
                    self.searchType2.text = personality
                    self.searchType2.isHidden = false
                } else {
                    self.searchType2.isHidden = true
                }
                if animal != "全部" {
                    self.searchType3.text = animal
                    self.searchType3.isHidden = false
                } else {
                    self.searchType3.isHidden = true
                }
                if month != "全部" {
                    self.searchType4.text = month
                    self.searchType4.isHidden = false
                } else {
                    self.searchType4.isHidden = true
                }
                
                if gender == "全部" && personality == "全部" && animal == "全部" && month == "全部" {
                    
                    self.isFilter = false
                    if self.isSearch {
                        return
                    } else {
                        self.animalAry = animalModel
                        self.collectionView.reloadData()
                        return
                    }
                    
                } else {
                    self.isFilter = true
                }
                
                if !self.isSearch {
                    self.animalAry = animalModel
                }
                
                var genderList: Array<Array<String>> = []
                if gender != "全部" {
                    for item in self.animalAry {
                        if item[1].contains(gender) {
                            genderList.append(item)
                        }
                    }
                } else {
                    genderList = self.animalAry
                }
                
                var personalityList: Array<Array<String>> = []
                if personality != "全部" {
                    for item in genderList {
                        if item[2].contains(personality) {
                            personalityList.append(item)
                        }
                    }
                } else {
                    personalityList = genderList
                }
                
                var animalList: Array<Array<String>> = []
                if animal != "全部" {
                    for item in personalityList {
                        if item[3].contains(animal) {
                            animalList.append(item)
                        }
                    }
                } else {
                    animalList = personalityList
                }
                
                var monthList: Array<Array<String>> = []
                if month != "全部" {
                    for item in animalList {
                        if item[4].contains(month) {
                            monthList.append(item)
                        }
                    }
                } else {
                    monthList = animalList
                }
                
                self.resultList = monthList
                
                self.animalAry = self.resultList
                self.collectionView.reloadData()
            })
        }
    }
    
    @IBAction func loadALL(_ sender: UIButton) {
        
        animalFilter = [0, 0, 0, 0]
        searchType1.isHidden = true
        searchType2.isHidden = true
        searchType3.isHidden = true
        searchType4.isHidden = true
        isFilter = false
        isSearch = false
        searchBar.text = ""
        animalAry = animalModel
        collectionView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            if isFilter {
                animalAry = resultList
            } else {
                animalAry = animalModel
            }
            collectionView.reloadData()
            isSearch = false
            return
        }
        
        isSearch = true
        
        var animalList: Array<Array<String>> = []
        
        for item in animalAry {
            
            if item[0].contains(searchText) {
                
                animalList.append(item)
            }
        }
        
        animalAry = animalList
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        view.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return animalAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalModelCell", for: indexPath) as! AnimalModelCell
        
        cell.animalName.text = animalAry[indexPath.row][0]
        cell.animalGender.text = animalAry[indexPath.row][1]
        cell.animalCharacter.text = animalAry[indexPath.row][2]
        cell.animalRace.text = animalAry[indexPath.row][3]
        cell.animalBirthday.text = animalAry[indexPath.row][4]
        cell.animalMantra.text = animalAry[indexPath.row][5]
        cell.animalAims.text = animalAry[indexPath.row][6]
        cell.animalMotto.text = animalAry[indexPath.row][7]
        cell.animalImageView.sd_setImage(with: URL(string: animalAry[indexPath.row][8]), completed: nil)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
    }
}
