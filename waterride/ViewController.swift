//
//  ViewController.swift
//  waterride
//
//  Created by JeongHwan Seok on 2021/02/23.
//

import UIKit

// textField객체의 텍스트 편집 및 유효성 검사를 관리하는데 사용하는 선택적 메소드 셋
class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var resultPrice: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var resultNum: UILabel!
    @IBOutlet weak var currentPrice: UITextField!
    @IBOutlet weak var currentNum: UITextField!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var newPrice: UITextField!
    @IBOutlet weak var newNum: UITextField!
    @IBOutlet weak var newValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.currentPrice.becomeFirstResponder()
        
        //currentPrice의 대리자를 내(view controller)가 할게
        currentPrice.delegate = self
        currentNum.delegate = self
        newPrice.delegate = self
        newNum.delegate = self
        
        
        // textField값 변경 시 calculateCurrent..메소드 호출 (실시간으로 변화)
        self.currentPrice.addTarget(self, action: #selector(self.calculateCurrent(_sender:)), for: .editingChanged)
        self.currentNum.addTarget(self, action: #selector(self.calculateCurrent(_sender:)), for: .editingChanged)
        self.newPrice.addTarget(self, action: #selector(self.calculateNew(_sender:)), for: .editingChanged)
        self.newNum.addTarget(self, action: #selector(self.calculateNew(_sender:)), for: .editingChanged)
        
        self.currentPrice.placeholder = "보유 평균 단가"
        self.currentNum.placeholder = "보유 수량"
        self.currentValue.text = "보유 금액"
        self.newPrice.placeholder = "추가 평균 단가"
        self.newNum.placeholder = "추가 수량"
        self.newValue.text = "추가 금액"
        currentPrice.font=UIFont(name: currentPrice.font!.fontName, size: 12)
        currentNum.font=UIFont(name: currentNum.font!.fontName, size: 12)
        newPrice.font=UIFont(name: newPrice.font!.fontName, size: 12)
        newNum.font=UIFont(name: newNum.font!.fontName, size: 12)
    }
    
    @IBAction func resetClick(_ sender: Any) {
        
        resultValue.text="최종 금액"
        resultNum.text="최종 수량"
        resultPrice.text="0"
        currentPrice.text=""
        currentNum.text=""
        currentValue.text="보유 금액"
        newPrice.text=""
        newNum.text=""
        newValue.text="추가 금액"
    }
    // 현재 보유 금액 계산
    @objc func calculateCurrent(_sender:Any?) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let removePrice = currentPrice.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let removeNum = currentNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")

            if let price = Int(removePrice!), let num = Int(removeNum!) {
                
                let beforeFormattedResult = price*num
                //계산한 결과에 콤마 넣기
                let result = numberFormatter.string(from: NSNumber(value: beforeFormattedResult))!
                currentValue.text=result
                
                //최종 금액 계산
                let removeOtherNum = newNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                let removeOtherValue = newValue.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                let removeValue = currentValue.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                
                if let otherNum = Int(removeOtherNum!), let otherValue = Int(removeOtherValue!), let thisValue = Int(removeValue!), let thisNum = Int(removeNum!) {
                    let beforeFormattedValue = Float(otherValue+thisValue)
                    let beforeFormattedNum = Float(otherNum+thisNum)
                    let temp = beforeFormattedValue/beforeFormattedNum
                    let beforeFormattedPrice = round(temp*100)/100 //소수 둘째자리 반올림
     
                    let valueResult = numberFormatter.string(from: NSNumber(value: beforeFormattedValue))
                    let numResult = numberFormatter.string(from: NSNumber(value: beforeFormattedNum))
                    let priceResult = numberFormatter.string(from: NSNumber(value: beforeFormattedPrice))
                    resultValue.text=valueResult
                    resultNum.text=numResult
                    resultPrice.text=priceResult
        
                
                }
                
            }
        
    }
    
    // 추가 매수 금액 계산
    @objc func calculateNew(_sender:Any?) {
 
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2 //허용하는 소수점 자리수
        
        let removePrice = newPrice.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        let removeNum = newNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
        
            if let price = Int(removePrice!), let num = Int(removeNum!) {
                
                let beforeFormattedResult = price*num
                //계산한 결과에 콤마 넣기
                let result = numberFormatter.string(from: NSNumber(value: beforeFormattedResult))!
                newValue.text=result
                
                //최종 금액 계산
                let removeOtherNum = currentNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                let removeOtherValue = currentValue.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                let removeValue = newValue.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")
                
                if let otherNum = Int(removeOtherNum!), let otherValue = Int(removeOtherValue!), let thisValue = Int(removeValue!), let thisNum = Int(removeNum!) {
                    let beforeFormattedValue = Float(otherValue+thisValue)
                    let beforeFormattedNum = Float(otherNum+thisNum)
                    let temp = beforeFormattedValue/beforeFormattedNum
                    let beforeFormattedPrice = round(temp*100)/100 //소수 둘째자리 반올림
     
                    let valueResult = numberFormatter.string(from: NSNumber(value: beforeFormattedValue))
                    let numResult = numberFormatter.string(from: NSNumber(value: beforeFormattedNum))
                    let priceResult = numberFormatter.string(from: NSNumber(value: beforeFormattedPrice))
                    resultValue.text=valueResult
                    resultNum.text=numResult
                    resultPrice.text=priceResult
        
                    
                }
                
            }
        
    }

    // 숫자 세 자리 숫자마다 콤마 넣기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString newString: String) -> Bool {
        //replacementString: 방금 입력된 문자 하나, 붙여넣기라면 문자열 전체
        //텍스트가 바뀌어야 한다면 true, 아니면 false
        //해당 메소드 내에서 currentPrice.text는 입력되기 전의 문자열
        
        // NumberFormatter 객체의 numberStyle을 .decimal로 설정
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0 //허용하는 소수점 자리수
        
        if textField == currentPrice {
            //이미 입력된 문자열의 그룹구분기호(groupingSeparator) 콤마 제거
            if let removeAllSeprator = currentPrice.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                // 콤마가 제거된 문자열과 새로 입력된 문자를 합친다.
                var beforeString = removeAllSeprator + newString
                
                // newString이 숫자만으로 이루어진 문자열이라면 해당 문자를 숫자로 바꾼 값을 NSNumber의 형태로 변환
                if numberFormatter.number(from: newString) != nil {
                    // 합친 문자열(beforeString)을 다시 원하는 포맷으로 변환 후 String으로 변환
                    if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                        currentPrice.text = formattedString
                        currentPrice.sendActions(for: .editingChanged)
                        return false
                    }
                } else { //새로 입력된 값이 숫자로 이루어진 문자열이 아닌 경우(백스페이스, 문자열..)
                    if newString == "" { //백스페이스의 경우 맨 마지막 문자열 자르고 재포맷 과정 거침
                        
                        let lastIndex = beforeString.index(beforeString.endIndex, offsetBy: -1)
                        beforeString = String(beforeString[..<lastIndex]) //..<는 인덱스 미만, 잘린 데이터의 타입은 substring->string 필요
                        
                        if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                            currentPrice.text = formattedString
                            currentPrice.sendActions(for: .editingChanged)
                            return false
                        
                        }
                    } else { //문자
                        return false
                    }
                }
            }
            return true
        }
        if textField == currentNum {
            //이미 입력된 문자열의 그룹구분기호(groupingSeparator) 콤마 제거
            if let removeAllSeprator = currentNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                // 콤마가 제거된 문자열과 새로 입력된 문자를 합친다.
                var beforeString = removeAllSeprator + newString
                
                // newString이 숫자만으로 이루어진 문자열이라면 해당 문자를 숫자로 바꾼 값을 NSNumber의 형태로 변환
                if numberFormatter.number(from: newString) != nil {
                    // 합친 문자열(beforeString)을 다시 원하는 포맷으로 변환 후 String으로 변환
                    if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                        currentNum.text = formattedString
                        currentNum.sendActions(for: .editingChanged)
                        return false
                    }
                } else { //새로 입력된 값이 숫자로 이루어진 문자열이 아닌 경우(백스페이스, 문자열..)
                    if newString == "" { //백스페이스의 경우 맨 마지막 문자열 자르고 재포맷 과정 거침
                        
                        let lastIndex = beforeString.index(beforeString.endIndex, offsetBy: -1)
                        beforeString = String(beforeString[..<lastIndex]) //..<는 인덱스 미만, 잘린 데이터의 타입은 substring->string 필요
                        
                        if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                            currentNum.text = formattedString
                            currentNum.sendActions(for: .editingChanged)
                            return false
                        
                        }
                    } else { //문자
                        return false
                    }
                }
            }
            return true
        }
        if textField == newPrice {
            //이미 입력된 문자열의 그룹구분기호(groupingSeparator) 콤마 제거
            if let removeAllSeprator = newPrice.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                // 콤마가 제거된 문자열과 새로 입력된 문자를 합친다.
                var beforeString = removeAllSeprator + newString
                
                // newString이 숫자만으로 이루어진 문자열이라면 해당 문자를 숫자로 바꾼 값을 NSNumber의 형태로 변환
                if numberFormatter.number(from: newString) != nil {
                    // 합친 문자열(beforeString)을 다시 원하는 포맷으로 변환 후 String으로 변환
                    if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                        newPrice.text = formattedString
                        newPrice.sendActions(for: .editingChanged)
                        return false
                    }
                } else { //새로 입력된 값이 숫자로 이루어진 문자열이 아닌 경우(백스페이스, 문자열..)
                    if newString == "" { //백스페이스의 경우 맨 마지막 문자열 자르고 재포맷 과정 거침
                        
                        /* 현재 커서 위치 가져오기
                        let textRange = newPrice.selectedTextRange!
                        let offset = newPrice.offset(from: newPrice.beginningOfDocument, to: textRange.start)
                        print(offset)
                        */
                        let lastIndex = beforeString.index(beforeString.endIndex, offsetBy: -1)
                        beforeString = String(beforeString[..<lastIndex]) //..<는 인덱스 미만, 잘린 데이터의 타입은 substring->string 필요
                        
                        if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                            newPrice.text = formattedString
                            newPrice.sendActions(for: .editingChanged)
                            return false
                        
                        }
                    } else { //문자
                        return false
                    }
                }
            }
            return true
        }
        if textField == newNum {
            //이미 입력된 문자열의 그룹구분기호(groupingSeparator) 콤마 제거
            if let removeAllSeprator = newNum.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
                // 콤마가 제거된 문자열과 새로 입력된 문자를 합친다.
                var beforeString = removeAllSeprator + newString
                
                // newString이 숫자만으로 이루어진 문자열이라면 해당 문자를 숫자로 바꾼 값을 NSNumber의 형태로 변환
                if numberFormatter.number(from: newString) != nil {
                    // 합친 문자열(beforeString)을 다시 원하는 포맷으로 변환 후 String으로 변환
                    if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                        newNum.text = formattedString
                        newNum.sendActions(for: .editingChanged)
                        return false
                    }
                } else { //새로 입력된 값이 숫자로 이루어진 문자열이 아닌 경우(백스페이스, 문자열..)
                    if newString == "" { //백스페이스의 경우 맨 마지막 문자열 자르고 재포맷 과정 거침
                        let lastIndex = beforeString.index(beforeString.endIndex, offsetBy: -1)
                        beforeString = String(beforeString[..<lastIndex]) //..<는 인덱스 미만, 잘린 데이터의 타입은 substring->string 필요
                        
                        if let formattedNumber = numberFormatter.number(from: beforeString), let formattedString = numberFormatter.string(from: formattedNumber) {
                            newNum.text = formattedString
                            newNum.sendActions(for: .editingChanged)
                            return false
                        
                        }
                    } else { //문자
                        return false
                    }
                }
            }
            return true
        }
        
        return true
    }
    
    
}
