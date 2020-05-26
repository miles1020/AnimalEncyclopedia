//
//  KohlrabiVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/21.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import SwiftCharts


class KohlrabiVC: UIViewController {
    
    var week = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    @IBOutlet weak var weekView: UIView!
    var chartAreasView: ChartAreasView!
    var popups: [UIView] = []
    var chart: Chart!
    @IBOutlet weak var chartBaseView: UIView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var mondayMorning: UITextField!
    @IBOutlet weak var mondayAfternoon: UITextField!
    @IBOutlet weak var tuesdayMorning: UITextField!
    @IBOutlet weak var tuesdayAfternoon: UITextField!
    @IBOutlet weak var wednesdayMorning: UITextField!
    @IBOutlet weak var wednesdayAfternoon: UITextField!
    @IBOutlet weak var thursdayMorning: UITextField!
    @IBOutlet weak var thursdayAfternoon: UITextField!
    @IBOutlet weak var fridayMorning: UITextField!
    @IBOutlet weak var fridayAfternoon: UITextField!
    @IBOutlet weak var saturdayMorning: UITextField!
    @IBOutlet weak var saturdayAfternoon: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var prediction1: UILabel!
    @IBOutlet weak var prediction2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mondayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        mondayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        tuesdayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        tuesdayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        wednesdayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        wednesdayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        thursdayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        thursdayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        fridayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        fridayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        saturdayMorning.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        saturdayAfternoon.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        
        if weekday == 1 {
            
            UserDefaults.standard.set(nil, forKey: "KohlrabiData")
        }
        
        if let kohlrabiData = UserDefaults.standard.array(forKey: "KohlrabiData") {
            
            price.text = kohlrabiData[0] as? String
            mondayMorning.text = kohlrabiData[1] as? String
            mondayAfternoon.text = kohlrabiData[2] as? String
            tuesdayMorning.text = kohlrabiData[3] as? String
            tuesdayAfternoon.text = kohlrabiData[4] as? String
            wednesdayMorning.text = kohlrabiData[5] as? String
            wednesdayAfternoon.text = kohlrabiData[6] as? String
            thursdayMorning.text = kohlrabiData[7] as? String
            thursdayAfternoon.text = kohlrabiData[8] as? String
            fridayMorning.text = kohlrabiData[9] as? String
            fridayAfternoon.text = kohlrabiData[10] as? String
            saturdayMorning.text = kohlrabiData[11] as? String
            saturdayAfternoon.text = kohlrabiData[12] as? String
            
            
        }
        
        initChart()
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        initChart()
    }
    
    func initChart() {
        
        if chart != nil {
            chart.view.removeFromSuperview()
            chart = nil
        }
        
        let monday1 = Int(mondayMorning.text!) ?? 0
        let monday2 = Int(mondayAfternoon.text!) ?? 0
        let tuesday1 = Int(tuesdayMorning.text!) ?? 0
        let tuesday2 = Int(tuesdayAfternoon.text!) ?? 0
        let wednesday1 = Int(wednesdayMorning.text!) ?? 0
        let wednesday2 = Int(wednesdayAfternoon.text!) ?? 0
        let thursday1 = Int(thursdayMorning.text!) ?? 0
        let thursday2 = Int(thursdayAfternoon.text!) ?? 0
        let friday1 = Int(fridayMorning.text!) ?? 0
        let friday2 = Int(fridayAfternoon.text!) ?? 0
        let saturday1 = Int(saturdayMorning.text!) ?? 0
        let saturday2 = Int(saturdayAfternoon.text!) ?? 0
        
        
        let chartPoints = [(1, monday1), (2, monday2), (3, tuesday1), (4, tuesday2), (5, wednesday1), (6, wednesday2), (7, thursday1), (8, thursday2), (9, friday1), (10, friday2), (11, saturday1), (12, saturday2)]
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 11))
        let chartPoints1 = chartPoints.map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        
        //        let allChartPoints = chartPoints1.sorted {(obj1, obj2) in return obj1.x.scalar < obj2.x.scalar}
        let xValues: [ChartAxisValue] = (NSOrderedSet(array: chartPoints1).array as! [ChartPoint]).map{$0.x}
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints1, minSegmentCount: 1, maxSegmentCount: 7, multiple: 100, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let chartFrame = CGRect(x: 0, y: 0, width: chartBaseView.frame.width, height: chartBaseView.frame.height)
        
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        chartSettings.trailing = 20
        chartSettings.labelsToAxisSpacingX = 20
        chartSettings.labelsToAxisSpacingY = 20
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: .systemBlue, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel1], pathGenerator: CatmullPathGenerator())
        
        let chartPointsLayer1 = ChartPointsAreaLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints1, areaColors: [.systemBlue], animDuration: 3, animDelay: 0, addContainerPoints: true, pathGenerator: chartPointsLineLayer.pathGenerator)
        
        var selectedView: ChartPointTextCircleView?
        
        let circleViewGenerator = { [weak self] (chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in guard let weakSelf = self else {return nil}
            
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            
            if "\(chartPoint.y)" == "0" {
                return nil
            }
            
            let v = ChartPointTextCircleView(chartPoint: chartPoint, center: screenLoc, diameter: 30, cornerRadius: 15, borderWidth: 1, font: UIFont.systemFont(ofSize: 11))
            v.text = "\(chartPoint.y)"
            v.viewTapped = {view in
                for p in weakSelf.popups {p.removeFromSuperview()}
                selectedView?.selected = false
                
                let w: CGFloat = 50
                let h: CGFloat = 30
                
                if let chartViewScreenLoc = layer.containerToGlobalScreenLoc(chartPoint) {
                    let x: CGFloat = {
                        let attempt = chartViewScreenLoc.x - (w/2)
                        let leftBound: CGFloat = chart.bounds.origin.x
                        let rightBound = chart.bounds.size.width - 5
                        if attempt < leftBound {
                            return view.frame.origin.x
                        } else if attempt + w > rightBound {
                            return rightBound - w
                        }
                        return attempt
                    }()
                    
                    let frame = CGRect(x: x, y: chartViewScreenLoc.y - (h + (18)), width: w, height: h)
                    
                    let bubbleView = InfoBubble(point: chartViewScreenLoc, frame: frame, arrowWidth: 28, arrowHeight: 14, bgColor: .clear, arrowX: chartViewScreenLoc.x - x, arrowY: -1)
                    bubbleView.transform = CGAffineTransform(scaleX: 0, y: 0).concatenating(CGAffineTransform(translationX: 0, y: 100))
                    bubbleView.clipsToBounds = true
                    bubbleView.layer.cornerRadius = 15
                    chart.view.addSubview(bubbleView)
                    
                    let infoView = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    infoView.center = CGPoint(x: 25, y: 15)
                    infoView.textColor = .black
                    infoView.backgroundColor = UIColor(red: 25/255, green: 135/255, blue: 252/255, alpha: 1)
                    infoView.text = "\(chartPoint.y)"
                    infoView.font = UIFont.systemFont(ofSize: 12)
                    infoView.textAlignment = NSTextAlignment.center
                    
                    bubbleView.addSubview(infoView)
                    weakSelf.popups.append(bubbleView)
                    
                    UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions(), animations: {
                        view.selected = true
                        selectedView = view
                        
                        bubbleView.transform = CGAffineTransform.identity
                    }, completion: {finished in})
                }
            }
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions(), animations: {
                let w: CGFloat = v.frame.size.width
                let h: CGFloat = v.frame.size.height
                let frame = CGRect(x: screenLoc.x - (w/2), y: screenLoc.y - (h/2), width: w, height: h)
                v.frame = frame
            }, completion: nil)
            
            return v
        }
        
        let itemsDelay: Float = 0.08
        
        // To not have circles clipped by the chart bounds, pass clipViews: false (and ChartSettings.customClipRect in case you want to clip them by other bounds)
        let chartPointsCircleLayer1 = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints1, viewGenerator: circleViewGenerator, displayDelay: 0.9, delayBetweenItems: itemsDelay, mode: .translate)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: 0.1)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLayer1,
                chartPointsLineLayer,
                chartPointsCircleLayer1
            ]
        )
        
        self.chart.delegate = self
        
        chartBaseView.addSubview(chart.view)
        chartBaseView.bringSubviewToFront(weekView)
    }
    
    func removePopups() {
        for popup in popups {
            popup.removeFromSuperview()
        }
    }
    
    func scrollViewBottomOffset() {
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    @IBAction func resetClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: "確定要清除資料嗎？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .destructive) { (alert) in
            
            UserDefaults.standard.set(nil, forKey: "KohlrabiData")
            self.price.text = ""
            self.mondayMorning.text = ""
            self.mondayAfternoon.text = ""
            self.tuesdayMorning.text = ""
            self.tuesdayAfternoon.text = ""
            self.wednesdayMorning.text = ""
            self.wednesdayAfternoon.text = ""
            self.thursdayMorning.text = ""
            self.thursdayAfternoon.text = ""
            self.fridayMorning.text = ""
            self.fridayAfternoon.text = ""
            self.saturdayMorning.text = ""
            self.saturdayAfternoon.text = ""
            self.initChart()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startCalculation(_ sender: UIButton) {
        
        let kohlrabiData: Array<String> = [
            price.text ?? "", mondayMorning.text ?? "", mondayAfternoon.text ?? "",
            tuesdayMorning.text ?? "", tuesdayAfternoon.text ?? "", wednesdayMorning.text ?? "",
            wednesdayAfternoon.text ?? "", wednesdayAfternoon.text ?? "", thursdayMorning.text ?? "",
            thursdayAfternoon.text ?? "", fridayMorning.text ?? "", fridayAfternoon.text ?? "",
            saturdayMorning.text ?? "", saturdayAfternoon.text ?? ""]
        
        UserDefaults.standard.set(kohlrabiData, forKey: "KohlrabiData")
        
        if price.text == "" || mondayMorning.text == "" {
            
            prediction1.text = "無法判斷"
            prediction2.text = "判斷大頭菜模型至少需要「起始基礎價格」以及「星期一上午價格」"
            DispatchQueue.main.async {
                self.scrollViewBottomOffset()
            }
            return
        }
        
        let p: Double = Double(price.text!)!
        var mondayM: Double = Double(mondayMorning.text!)!
        var mondayA: Double = 0
        var tuesdayM: Double = 0
        var tuesdayA: Double = 0
        var wednesdayM: Double = 0
        var wednesdayA: Double = 0
        var thursdayM: Double = 0
        var thursdayA: Double = 0
        var fridayM: Double = 0
        
        let r1 = mondayM / p
        if r1 >= 0.9 {
            
            if mondayAfternoon.text == "" && tuesdayMorning.text == "" {
                
                prediction1.text = "可能為「四期型」或「波型」"
                prediction2.text = "因為缺少「星期一下午價格」以及「星期二上午價格」，所以只能預測可能的模型"
                DispatchQueue.main.async {
                    self.scrollViewBottomOffset()
                }
                return
            }
                
            if mondayAfternoon.text != "" && tuesdayMorning.text == "" {
                
                mondayA = Double(mondayAfternoon.text!)!
                
                if (mondayA / p) > 0.8 {
                    prediction1.text = "可能為「四期型」或「波型」"
                    prediction2.text = "因為缺少「星期二上午價格」，所以只能預測可能的模型"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                } else {
                    
                    prediction1.text = "波型"
                    prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                }
            }
            
            
            if mondayAfternoon.text == "" && tuesdayMorning.text != "" {
                
                tuesdayM = Double(tuesdayMorning.text!)!
                if tuesdayM / p >= 1.4 {
                    prediction1.text = "四期型"
                    prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                } else {
                    
                    prediction1.text = "波型"
                    prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                }
            }
            
            let r211 = mondayA / p
            let r212 = tuesdayM / p
            if r211 < 0.8 || r212 < 1.4 {
                
                prediction1.text = "波型"
                prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                DispatchQueue.main.async {
                    self.scrollViewBottomOffset()
                }
                return
            } else {
                
                prediction1.text = "四期型"
                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                DispatchQueue.main.async {
                    self.scrollViewBottomOffset()
                }
                return
            }
        } else if r1 < 0.9 && r1 >= 0.85 {
            
            if mondayMorning.text != "" && mondayAfternoon.text != "" &&
                tuesdayMorning.text != "" && tuesdayAfternoon.text != "" &&
                wednesdayMorning.text != "" && wednesdayAfternoon.text != "" &&
                thursdayMorning.text != "" && thursdayAfternoon.text != ""  {
                
                mondayM = Double(mondayMorning.text!)!
                mondayA = Double(mondayAfternoon.text!)!
                tuesdayM = Double(tuesdayMorning.text!)!
                tuesdayA = Double(tuesdayAfternoon.text!)!
                wednesdayM = Double(wednesdayMorning.text!)!
                wednesdayA = Double(wednesdayAfternoon.text!)!
                thursdayM = Double(thursdayMorning.text!)!
                thursdayA = Double(thursdayAfternoon.text!)!
                
                if mondayM > mondayA && mondayA > tuesdayM &&
                    tuesdayM > tuesdayA && tuesdayA > wednesdayM &&
                    wednesdayM > wednesdayA && wednesdayA > thursdayM &&
                    thursdayM > thursdayA {
                    
                    prediction1.text = "遞減型"
                    prediction2.text = "最淺顯易懂的模型，一定不會賺錢"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                } else {
                    
                    if mondayM < mondayA {
                        
                        if tuesdayM / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if mondayA < tuesdayM {
                        
                        if tuesdayA / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if tuesdayM < tuesdayA {
                        
                        if wednesdayM / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if tuesdayA < wednesdayM {
                        
                        if wednesdayA / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if wednesdayM < wednesdayA {
                        
                        if thursdayM / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if wednesdayA < thursdayM {
                        
                        if thursdayA / p > 1.4 {
                            
                            prediction1.text = "三期型"
                            prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        } else {
                            
                            prediction1.text = "四期型"
                            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    if thursdayM < thursdayA {
                        
                        if fridayMorning.text != "" {
                            
                            fridayM = Double(fridayMorning.text!)!
                            if fridayM / p > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        } else {
                            
                            prediction1.text = "可能為「三期型」或「四期型」"
                            prediction2.text = "因為缺少了星期五上午的價格，所以僅能判斷為「三期型」或「四期型」"
                            DispatchQueue.main.async {
                                self.scrollViewBottomOffset()
                            }
                            return
                        }
                    }
                    
                    prediction1.text = "遞減型"
                    prediction2.text = "最淺顯易懂的模型，一定不會賺錢"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                }
            } else {
                
                if mondayMorning.text != "" && mondayAfternoon.text != "" {
                    
                    mondayM = Double(mondayMorning.text!)!
                    mondayA = Double(mondayAfternoon.text!)!
                    if tuesdayMorning.text != "" {
                        
                        tuesdayM = Double(tuesdayMorning.text!)!
                        if mondayM < mondayA {
                            
                            if tuesdayM / p > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                            
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期二上午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                if mondayAfternoon.text != "" && tuesdayMorning.text != "" {
                    
                    mondayA = Double(mondayAfternoon.text!)!
                    tuesdayM = Double(tuesdayMorning.text!)!
                    if tuesdayAfternoon.text != "" {
                        
                        tuesdayA = Double(tuesdayAfternoon.text!)!
                        if mondayA < tuesdayM {
                            
                            if tuesdayA / p > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                        
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期二下午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                if tuesdayAfternoon.text != "" && wednesdayMorning.text != "" {
                    
                    tuesdayA = Double(tuesdayAfternoon.text!)!
                    wednesdayM = Double(wednesdayMorning.text!)!
                    if wednesdayAfternoon.text != "" {
                        
                        wednesdayA = Double(wednesdayAfternoon.text!)!
                        if tuesdayA < wednesdayM {
                            
                            let r3 = wednesdayA / p
                            if r3 > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                        
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期三下午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                if wednesdayMorning.text != "" && wednesdayAfternoon.text != "" {
                    
                    wednesdayM = Double(wednesdayMorning.text!)!
                    wednesdayA = Double(wednesdayAfternoon.text!)!
                    if thursdayMorning.text != "" {
                        
                        thursdayM = Double(thursdayMorning.text!)!
                        if wednesdayM < wednesdayA {
                            
                            let r3 = thursdayM / p
                            if r3 > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                        
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期四上午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                if wednesdayAfternoon.text != "" && thursdayMorning.text != "" {
                    
                    wednesdayA = Double(wednesdayAfternoon.text!)!
                    thursdayM = Double(thursdayMorning.text!)!
                    if thursdayAfternoon.text != "" {
                        
                        thursdayA = Double(thursdayAfternoon.text!)!
                        if wednesdayA < thursdayM {
                            
                            let r3 = thursdayA / p
                            if r3 > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                        
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期四下午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                if thursdayMorning.text != "" && thursdayAfternoon.text != "" {
                    
                    thursdayM = Double(thursdayMorning.text!)!
                    thursdayA = Double(thursdayAfternoon.text!)!
                    if fridayMorning.text != "" {
                        
                        fridayM = Double(fridayMorning.text!)!
                        if thursdayM < thursdayA {
                            
                            let r3 = fridayM / p
                            if r3 > 1.4 {
                                
                                prediction1.text = "三期型"
                                prediction2.text = "最刺激好賺的模型，要發大財就要靠這個"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            } else {
                                
                                prediction1.text = "四期型"
                                prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                    } else {
                        
                        prediction1.text = "「三期型」、「四期型」或「遞減型」"
                        prediction2.text = "因為缺乏了「星期五上午」的價格，因此僅能預估為「三期型」、「四期型」或「遞減型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
                    
                prediction1.text = "「三期型」、「四期型」或「遞減型」"
                prediction2.text = "因為缺乏星期一上午至星期四下午的連續價格資料，所以只能預測可能的模型"
                DispatchQueue.main.async {
                    self.scrollViewBottomOffset()
                }
                return
            } 
        } else if r1 < 0.85 && r1 >= 0.8 {
            
            prediction1.text = "四期型"
            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
            DispatchQueue.main.async {
                self.scrollViewBottomOffset()
            }
            return
        } else if r1 < 0.8 && r1 >= 0.6 {
            
            if mondayAfternoon.text == "" && tuesdayMorning.text == "" {
                
                prediction1.text = "可能為「四期型」或「波型」"
                prediction2.text = "因為缺乏星期一上午至星期二下午的價格資料，所以只能預測可能的模型"
                DispatchQueue.main.async {
                    self.scrollViewBottomOffset()
                }
                return
            } else if mondayAfternoon.text != "" && tuesdayMorning.text == "" {
                
                mondayA = Double(mondayAfternoon.text!)!
                let r221 = (mondayM / p) - (mondayA / p)
                if r221 >= 0.05 {
                    
                    prediction1.text = "波型"
                    prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                } else {
                    
                    prediction1.text = "可能為「四期型」或「波型」"
                    prediction2.text = "因為星期二上午的價格資料，所以只能預測可能的模型"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                }
            } else {
                
                mondayA = Double(mondayAfternoon.text!)!
                tuesdayM = Double(tuesdayMorning.text!)!
                
                let r221 = (mondayM / p) - (mondayA / p)
                let r222 = (mondayA / p) - (tuesdayM / p)
                
                if r221 >= 0.05 || r222 >= 0.05 {
                    
                    prediction1.text = "波型"
                    prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                    DispatchQueue.main.async {
                        self.scrollViewBottomOffset()
                    }
                    return
                } else {
                    
                    if r221 < 0.04 || r222 < 0.04 {
                        
                        prediction1.text = "四期型"
                        prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    } else {
                        
                        if mondayMorning.text != "" && mondayAfternoon.text != "" &&
                            tuesdayMorning.text != "" && tuesdayAfternoon.text != "" {
                            
                            mondayM = Double(mondayMorning.text!)!
                            mondayA = Double(mondayAfternoon.text!)!
                            tuesdayM = Double(tuesdayMorning.text!)!
                            tuesdayA = Double(tuesdayAfternoon.text!)!
                            
                            if mondayM > mondayA && mondayA > tuesdayM &&
                                tuesdayM < tuesdayA {
                                
                                if wednesdayAfternoon.text != "" {
                                    
                                    wednesdayA = Double(wednesdayAfternoon.text!)!
                                    if (wednesdayA / p) >= 1.4 {
                                        
                                        prediction1.text = "四期型"
                                        prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                        DispatchQueue.main.async {
                                            self.scrollViewBottomOffset()
                                        }
                                        return
                                    } else {
                                        
                                        prediction1.text = "波型"
                                        prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                                        DispatchQueue.main.async {
                                            self.scrollViewBottomOffset()
                                        }
                                        return
                                    }
                                } else {
                                    
                                    prediction1.text = "「四期型」或「波型」"
                                    prediction2.text = "因為缺乏「星期三下午」的大頭菜價格，因此只能推估為「四期型」或「波型」"
                                    DispatchQueue.main.async {
                                        self.scrollViewBottomOffset()
                                    }
                                    return
                                }
                            } else {
                                
                                prediction1.text = "波型"
                                prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                        
                        if mondayMorning.text != "" && mondayAfternoon.text != "" &&
                            tuesdayMorning.text != "" {
                            
                            mondayM = Double(mondayMorning.text!)!
                            mondayA = Double(mondayAfternoon.text!)!
                            tuesdayM = Double(tuesdayMorning.text!)!
                            if mondayM > mondayA && mondayA < tuesdayM {
                                
                                if wednesdayMorning.text != "" {
                                    
                                    wednesdayM = Double(wednesdayMorning.text!)!
                                    if (wednesdayM / p) >= 1.4 {
                                        
                                        prediction1.text = "四期型"
                                        prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
                                        DispatchQueue.main.async {
                                            self.scrollViewBottomOffset()
                                        }
                                        return
                                    } else {
                                        
                                        prediction1.text = "波型"
                                        prediction2.text = "波型固定會有 2 次的下跌階段與 3 次的上漲階段"
                                        DispatchQueue.main.async {
                                            self.scrollViewBottomOffset()
                                        }
                                        return
                                    }
                                } else {
                                    
                                    prediction1.text = "「四期型」或「波型」"
                                    prediction2.text = "因為缺乏「星期三下午」的大頭菜價格，因此只能推估為「四期型」或「波型」"
                                    DispatchQueue.main.async {
                                        self.scrollViewBottomOffset()
                                    }
                                    return
                                }
                            } else {
                                
                                prediction1.text = "「四期型」或「波型」"
                                prediction2.text = "因為缺乏「星期三下午」的大頭菜價格，因此只能推估為「四期型」或「波型」"
                                DispatchQueue.main.async {
                                    self.scrollViewBottomOffset()
                                }
                                return
                            }
                        }
                        
                        prediction1.text = "「四期型」或「波型」"
                        prediction2.text = "因為缺乏「星期三下午」的大頭菜價格，因此只能推估為「四期型」或「波型」"
                        DispatchQueue.main.async {
                            self.scrollViewBottomOffset()
                        }
                        return
                    }
                }
            }
        } else if r1 < 0.6 {
            
            prediction1.text = "四期型"
            prediction2.text = "相當平均的模型，容易在早期發現，也可以賣到上限 2 倍買價的錢，不錯"
            DispatchQueue.main.async {
                self.scrollViewBottomOffset()
            }
            return
        }
    }
}

extension UIScrollView {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}

extension KohlrabiVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        view.endEditing(true)
    }
}

extension KohlrabiVC: ChartDelegate {
    
    func onZoom(scaleX: CGFloat, scaleY: CGFloat, deltaX: CGFloat, deltaY: CGFloat, centerX: CGFloat, centerY: CGFloat, isGesture: Bool) {
        
    }
    
    func onPan(transX: CGFloat, transY: CGFloat, deltaX: CGFloat, deltaY: CGFloat, isGesture: Bool, isDeceleration: Bool) {
        
    }
    
    func onTap(_ models: [TappedChartPointLayerModels<ChartPoint>]) {
        removePopups()
    }
}

extension KohlrabiVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newText == "0" {
            return false
        }
        
        let numberOfChars = newText.count
        
        if numberOfChars > 3 {
            showToast("最多三位數")
            textField.shake()
        }
        
        return numberOfChars <= 3
    }
}
