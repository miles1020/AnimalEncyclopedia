//
//  FilterView.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/6.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

enum Gender: String {
    case man = "♂"
    case woman = "♀"
    case normal = ""
}

let animalColor = UIColor(red: 197/255, green: 243/255, blue: 208/255, alpha: 1)

class FilterView: UIView {
    
    let genderAry = ["全部", "♂", "♀"]
    var personalityAry: Array<String> = ["全部", "元氣", "普通", "成熟", "大姐姐", "自戀", "運動", "悠閒", "暴躁"]
    var animalAry: Array<String> = ["全部", "狗", "青蛙", "食蟻獸", "猩猩", "貓", "狼", "松鼠",
                     "雞", "老鷹", "豬", "馬", "章魚", "鹿", "獅子",
                     "鳥", "老鼠", "牛", "小熊", "大熊", "鱷魚",
                     "綿羊", "山羊", "鴨", "猴子", "袋鼠", "大象", "犀牛",
                     "無尾熊", "鴕鳥", "兔子", "企鵝", "河馬", "倉鼠", "老虎"]
    var monthAry: Array<String> = ["全部", "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    
    var genderSelect = 0
    var personalitySelect = 0
    var animalSelect = 0
    var monthSelect = 0
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var personalityBtn: UIButton!
    @IBOutlet weak var animalBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    
    var onSuccess: ((Dictionary<String, Any>) -> ())!
    
    func setData(data: Array<Int>, onSuccess: @escaping (Dictionary<String, Any>) -> ()) {

        self.onSuccess = onSuccess
        
        genderSelect = data[0]
        personalitySelect = data[1]
        animalSelect = data[2]
        monthSelect = data[3]
        
        genderBtn.setTitle("\(genderAry[genderSelect]) ▼", for: .normal)
        personalityBtn.setTitle("\(personalityAry[personalitySelect]) ▼", for: .normal)
        animalBtn.setTitle("\(animalAry[animalSelect]) ▼", for: .normal)
        monthBtn.setTitle("\(monthAry[monthSelect]) ▼", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func genderClick(_ sender: UIButton) {
        let customPickerView = CustomPickerView(genderAry) { (select) in
            sender.setTitle("\(self.genderAry[select as! Int]) ▼", for: .normal)
            self.genderSelect = select as! Int
        }
        customPickerView.lastSelect = genderSelect
    }
    
    @IBAction func personalityClick(_ sender: UIButton) {
        let customPickerView = CustomPickerView(personalityAry) { (select) in
            sender.setTitle("\(self.personalityAry[select as! Int]) ▼", for: .normal)
            self.personalitySelect = select as! Int
        }
        customPickerView.lastSelect = personalitySelect
    }
    
    @IBAction func raceClick(_ sender: UIButton) {
        let customPickerView = CustomPickerView(animalAry) { (select) in
            sender.setTitle("\(self.animalAry[select as! Int]) ▼", for: .normal)
            self.animalSelect = select as! Int
        }
        customPickerView.lastSelect = animalSelect
    }
    
    @IBAction func birthdayClick(_ sender: UIButton) {
        let customPickerView = CustomPickerView(monthAry) { (select) in
            sender.setTitle("\(self.monthAry[select as! Int]) ▼", for: .normal)
            self.monthSelect = select as! Int
        }
        customPickerView.lastSelect = monthSelect
    }
    
    @IBAction func determineClick(_ sender: UIButton) {
        
        let data = ["gender":genderAry[genderSelect],
                    "personality":personalityAry[personalitySelect],
                    "animal":animalAry[animalSelect],
                    "month":monthAry[monthSelect]]
        animalFilter = [genderSelect, personalitySelect, animalSelect, monthSelect]
        onSuccess(data)
        
        UIView.animate(withDuration: 0.3, animations: {
         
            self.alpha = 0
        }) { (bool) in
            
            self.removeFromSuperview()
        }
    }
}
