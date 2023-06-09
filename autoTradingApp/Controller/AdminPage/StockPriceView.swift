//
//  StockPriceView.swift
//  autoTradingApp
//
//  Created by 이민형 on 2023/06/09.
//

import UIKit

// API framework 선언
import XingAPIMobile

//구조체를 사용한 데이터 처리 샘플
class StockPriceView: UIViewController, UITextFieldDelegate, XingAPIDelegate{

    let resultText = UILabel()
    let codeEdit = UITextField()
    let queryOutText = UITextView()
    
    var m_apihandle = -1
    var t1102RqID = -1
    var m_strCode = ""
    
    let eBESTAPI: XingAPI = XingAPI.getInstance()
    
    //해당 이름의 res 파일이 앱 안에 반드시 존재해야 한다
    //"RES_Files" 폴더 참조
    let realData = RES("S3_")
    let t1102 = RES("t1102")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        
        AddControls()
        
        //res 파일 로딩
        t1102.read()
        realData.read()
        
        //해당 뷰를 등록한다.
        //뷰 등록은 "viewDidLoad" 에서 반드시 한번만 한다.
        //뷰 하나당 1개의 핸들이 존재해야 한다.
        m_apihandle = eBESTAPI.initView(self, name:"Sample_01_VC")
        
        print("Sample_01_VC handle : \(m_apihandle)")
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        
        //현재 view에서 요청했던 모든 실시간을 중지하고 해당 view에 대한 정보를 삭제한다.
        //반드시 view가 사라질때 아래 api 함수를 호출해 줘야 한다.
        eBESTAPI.deinitView(m_apihandle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if m_apihandle > -1 && m_strCode.count > 0 {
            RequestRealData(code:m_strCode)
        }
    }

    //컨트롤 등록
    func AddControls()
    {
        //종목 입력
        codeEdit.placeholder = "종목코드 입력"
        codeEdit.font = UIFont.systemFont(ofSize: 15)
        codeEdit.borderStyle = UITextField.BorderStyle.roundedRect
        codeEdit.autocorrectionType = UITextAutocorrectionType.no
        codeEdit.keyboardType = UIKeyboardType.default
        codeEdit.returnKeyType = UIReturnKeyType.done
        codeEdit.clearButtonMode = UITextField.ViewMode.whileEditing
        codeEdit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        codeEdit.translatesAutoresizingMaskIntoConstraints = false
        codeEdit.delegate = self
        self.view.addSubview(codeEdit)
        
        //조회 버튼
        let queryBtn = UIButton()
        queryBtn.translatesAutoresizingMaskIntoConstraints = false
        queryBtn.setTitle("조회", for: UIControl.State.normal)
        queryBtn.backgroundColor = .orange
        queryBtn.layer.cornerRadius = 5
        queryBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        queryBtn.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        queryBtn.addTarget(self, action: #selector(OnQueryBtnClicked), for: .touchUpInside)
        self.view.addSubview(queryBtn)
        
        //메시지
        resultText.numberOfLines = 1
        resultText.text = ""
        resultText.translatesAutoresizingMaskIntoConstraints = false
        resultText.textAlignment = .left
        resultText.textColor = UIColor.black
        resultText.layer.borderColor = UIColor.lightGray.cgColor;
        resultText.layer.borderWidth = 1.0;
        self.view.addSubview(resultText)
        
        //조회 결과
        queryOutText.translatesAutoresizingMaskIntoConstraints = false
        queryOutText.textAlignment = .left
        queryOutText.textColor = UIColor.black
        queryOutText.font = UIFont.systemFont(ofSize:18)
        queryOutText.isEditable = false
        queryOutText.layer.borderColor = UIColor.lightGray.cgColor;
        queryOutText.layer.borderWidth = 1.0;
        self.view.addSubview(queryOutText)
        
        //layout 조정
        let margins = self.view.layoutMarginsGuide
        
        codeEdit.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5.0).isActive = true
        codeEdit.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0.0).isActive = true
        codeEdit.rightAnchor.constraint(equalTo: codeEdit.leftAnchor, constant: 250.0).isActive = true
        codeEdit.bottomAnchor.constraint(equalTo: codeEdit.topAnchor, constant: 40.0).isActive = true
        
        queryBtn.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5.0).isActive = true
        queryBtn.leftAnchor.constraint(equalTo: codeEdit.rightAnchor, constant: 5.0).isActive = true
        queryBtn.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0.0).isActive = true
        queryBtn.bottomAnchor.constraint(equalTo: queryBtn.topAnchor, constant: 40.0).isActive = true
        
        resultText.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0.0).isActive = true
        resultText.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0.0).isActive = true
        resultText.topAnchor.constraint(equalTo: codeEdit.bottomAnchor, constant: 10.0).isActive = true
        resultText.bottomAnchor.constraint(equalTo: resultText.topAnchor, constant: 30.0).isActive = true
        
        queryOutText.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0.0).isActive = true
        queryOutText.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0.0).isActive = true
        queryOutText.topAnchor.constraint(equalTo: resultText.bottomAnchor, constant: 10.0).isActive = true
        queryOutText.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10.0).isActive = true
        
    }
    
    //조회 버튼 이벤트
    @IBAction func OnQueryBtnClicked(_ sender: Any) {
        let code = codeEdit.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        if code.count != 6 {
            resultText.text = "종목코드를 확인해 주세요."
            return
        }
        
        if m_strCode.count == 6 {
            StopRealData(code: m_strCode)
        }
        
        m_strCode = code
        
        //input block 값 생성
        t1102.setFieldData("t1102InBlock", fieldName: "shcode", occursIndex: 0, data: code)
        
        //API로 보낸 input 데이터를 가져온다.
        let data = t1102.getInputBlockData()
        
        //데이터를 요청한다.
        let result = eBESTAPI.requestData(m_apihandle, code: "t1102", data: data, next: false, continueKey: "", compress: false, timeOut: 30)
        
        if result.ok == true {
            t1102RqID = result.rqID
        }
        
        resultText.text = result.rsltMsg.msg;
        
    }
    
    
    func Receive_t1102Data(data:Data, blockName:String )
    {
        if t1102.setOutputData(data, blockName: blockName) == true {
            var str = ""
            var allStr = ""
            str = t1102.getFieldData(blockName, fieldName: "price", occursIndex: 0)
            allStr += "현재가: " + str + "\r\n"
            str = t1102.getFieldData(blockName, fieldName: "change", occursIndex: 0)
            allStr += "등락: " + str + "\r\n"
            str = t1102.getFieldData(blockName, fieldName: "diff", occursIndex: 0)
            allStr += "등락율: " + str + "\r\n"
            str = t1102.getFieldData(blockName, fieldName: "volume", occursIndex: 0)
            allStr += "거래량: " + str + "\r\n"
            
            queryOutText.text = allStr
            
            RequestRealData(code: m_strCode)
        }
    }
    
    //실시간 데이터 처리
    func ReceiveRealData(bcCode: String, key: String, data: Data)
    {
        if bcCode == "S3_" || bcCode == "K3_"
        {
            if key == m_strCode {
                if realData.setOutputData(data, blockName: "") == true {
                    var str = ""
                    var allStr = ""
                    str = realData.getFieldData("OutBlock", fieldName: "price", occursIndex: 0)
                    allStr += "현재가: " + str + "\r\n"
                    str = realData.getFieldData("OutBlock", fieldName: "change", occursIndex: 0)
                    allStr += "등락: " + str + "\r\n"
                    str = realData.getFieldData("OutBlock", fieldName: "drate", occursIndex: 0)
                    allStr += "등락율: " + str + "\r\n"
                    str = realData.getFieldData("OutBlock", fieldName: "volume", occursIndex: 0)
                    allStr += "거래량: " + str + "\r\n"
                    
                    queryOutText.text = allStr
                }
            }
        }
    }
    
    
    //실시간 요청
    func RequestRealData(code:String)
    {
        eBESTAPI.adviseRealData( m_apihandle, code: "S3_", key: code)
        eBESTAPI.adviseRealData( m_apihandle, code: "K3_", key: code)
    }
    
    //실시간 중지
    func StopRealData(code:String)
    {
        eBESTAPI.unAdviseRealData( m_apihandle, code: "S3_", key: code)
        eBESTAPI.unAdviseRealData( m_apihandle, code: "K3_", key: code)
    }
    
    
    // MARK:- ---> UITextFieldDelegate start
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    // MARK:- ---> UITextFieldDelegate end
    
    
    // MARK:- ---> XingAPIDelegate start
    // API framework에서 호출되는 이벤트
    // tr 요청 결과 응답
    func onReceiveData(_ data: ReceiveData!) {
        let rqId = data.rqID
        //현재가 데이터
        if rqId == self.t1102RqID {
            Receive_t1102Data(data: data.data, blockName: data.blockName)
        }
    }
    
    // tr 요청 결과 메시지
    func onReceiveMessage(_ msg: ReceiveMessage!) {
        resultText.text = msg.message
    }
    
    // tr 요청 에러 메시지
    func onReceiveError(_ msg: ReceiveMessage!) {
        resultText.text = msg.message
    }
    
    func onReleaseData(_ rqID: Int, code: String!) {
    }
    
    func onTimeOut(_ rqID: Int, code: String!) {
         resultText.text = "Time out : " + code
    }
    
    // 실시간 데이터 이벤트
    func onReceiveRealData(_ bcCode: String!, key: String!, data: Data!) {
        ReceiveRealData(bcCode: bcCode, key: key, data: data)
    }
    
    // MARK:- ---> XingAPIDelegate end
}
