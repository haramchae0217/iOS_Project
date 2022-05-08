//
//  LineViewController.swift
//  ChartExample
//
//  Created by Chae_Haram on 2022/05/08.
//

import UIKit
import Charts

class LineViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var numberTextField: UITextField!
    
    var numbers: [Double] = [3.3, 2.4, 11.4, 7.6, 4.4, 8.4, 5.5]
    var months: [String] = ["1월","2월","3월","4월","5월","6월","7월"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawGraph()
    }
    
    func drawGraph() {
        var chartEntry: [ChartDataEntry] = [] // 그래프를 그릴때마다 초기화를 시켜줘야함. 이유 : 계속 데이터 값이 중첩됨.
        // chart에 들어갈 데이터를 생성.
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            chartEntry.append(value)
        }
        
        // chart 만들 준비단계
        // entry : 데이터 값
        // label : 지을 이름 명
        let lineGraph = LineChartDataSet(entries: chartEntry, label: "숫자 데이터")
        lineGraph.colors = [.systemRed] // 줄 색상 변경
        lineGraph.circleColors = [.systemOrange] // 동그라미 색상 변경
        
        let data = LineChartData()
        data.addDataSet(lineGraph)
        
        // chart에 보여질 데이터 오브젝트
        // chart를 실질적으로 보여주는 단계
        lineChartView.data = data
        // 그래프의 닉네임 형성
        lineChartView.chartDescription?.text = "나의 꺾은선 그래프"
        
        // 아래 라벨의 이름을 달로 설정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.labelPosition = .bottom
        
        // 차트 오른쪽 없어짐
        lineChartView.rightAxis.enabled = false
        
        // 차트 시간차 애니메이션
        lineChartView.animate(xAxisDuration: 2.0)
    }
    
    @IBAction func addDataButton(_ sender: UIButton) {
        let newData = Double(numberTextField.text!)
        numbers.append(newData!)
        
        drawGraph()
        numberTextField.text = ""
    }
    
    

}
