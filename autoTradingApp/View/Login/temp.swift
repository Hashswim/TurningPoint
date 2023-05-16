////
////  LoginViewController.swift
////  XingAPI_Sample
////
////  Created by eBEST on 2020. 3. 17..
////  Copyright © 2020년 eBEST INVESTMENT. All rights reserved.
////
//
//import UIKit
//
//// API framework 선언
//import XingAPIMobile
//
//// API에서 보내주는 이벤트를 받기 위해 XingAPIDelegate 프로토콜을 반드시 상속 받아야 한다.
//class temp: UIViewController, XingAPIDelegate{
//    
//    let LoginBtn = UIButton()
//    let resultLabel = UILabel()
//    var m_apihandle : Int = -1
//    let eBESTAPI: XingAPI = XingAPI.getInstance()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
//        
//        AddControls()
//    }
//    
//    func SetLoginStateText()
//    {
//        var loginBtnText = "API 로그인"
//        if  eBESTAPI.isLogin() == true
//        {
//            loginBtnText = "API 로그아웃"
//        }
//        LoginBtn.setTitle(loginBtnText, for: UIControl.State.normal)
//    }
//
//    func AddControls()
//    {
//        //로그인 버튼
//        LoginBtn.translatesAutoresizingMaskIntoConstraints = false
//        LoginBtn.backgroundColor = .orange
//        LoginBtn.layer.cornerRadius = 5
//        LoginBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        LoginBtn.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
//        LoginBtn.addTarget(self, action: #selector(OnLoginBtnClicked), for: .touchUpInside)
//        self.view.addSubview(LoginBtn)
//        
//        //결과출력
//        resultLabel.numberOfLines = 0
//        resultLabel.text = ""
//        resultLabel.translatesAutoresizingMaskIntoConstraints = false
//        resultLabel.textAlignment = .left
//        resultLabel.textColor = UIColor.black
//        self.view.addSubview(resultLabel)
//        
//        //layout 조정
//        let margins = self.view.layoutMarginsGuide
//        
//        LoginBtn.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 10.0).isActive = true
//        LoginBtn.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -10.0).isActive = true
//        LoginBtn.topAnchor.constraint(equalTo: margins.centerYAnchor, constant: -40.0).isActive = true
//        LoginBtn.bottomAnchor.constraint(equalTo: LoginBtn.topAnchor, constant: 50.0).isActive = true
//        
//        resultLabel.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 10.0).isActive = true
//        resultLabel.topAnchor.constraint(equalTo: LoginBtn.bottomAnchor, constant: 20.0).isActive = true
//        
//        SetLoginStateText()
//        
//    }
//    
//    //로그인 클릭 이벤트
//    @IBAction func OnLoginBtnClicked(_ sender: Any) {
//        resultLabel.text = ""
//        
//        let login = eBESTAPI.isLogin()
//        
//        if login == true {
//            eBESTAPI.logout()
//            LoginBtn.setTitle("로그인", for: UIControl.State.normal)
//            resultLabel.text = "로그아웃 되었습니다."
//            
//        } else {
//            
//            //일반적으로 화면에서는 viewDidLoad 함수에서 한번만 InitView를 호출하면 되지만
//            //로그아웃 또는 discount시 모든 handle이 지워지기 때문에
//            //로그아웃이 있는 화면은 로그인시 화면을 등록하고 새로운 핸들번호를 받아와야 한다.
//            m_apihandle = eBESTAPI.initView(self, name:"LoginViewController")
//            print(" aip handle : \(m_apihandle)")
//            
//            //API 코어에서 더 이상 핸드를 보유하고 있지 않는 경우 m_apihandle 값이 -1이 된다
//            //-1인 경우에 서로다른 이름으로 무수히 많이 eBESTAPI.InitView 함수가 호출되지 않았나 확인해 봐야 한다.
//            //위에서 언급한 아주 특별한 경우가 아닌 이상 일반적으로 -1 값이 나오는 경우는 없다.
//            if m_apihandle > 0
//            {
//                //var loginData = LOGIN_DATA(m_apihandle, connect_server: SERVER_TYPE.MOTU_SERVER)
//                let loginData = LOGIN_DATA(m_apihandle, connect_server: SERVER_TYPE.API_SERVER);
//                
//                //API의 내장된 로그인 뷰(인증서로그인)를 보고싶을 때
//                //loginData.showLoginView = true 로 설정한다
//                loginData.showLoginView = true
//                
//                //운영서버 로그인
//                if loginData.connect_server == SERVER_TYPE.API_SERVER
//                {
//                    let pubCertList = eBESTAPI.getSignList();
//                    if pubCertList.count > 0
//                    {
//                        loginData.pubCertIdx = 0
//                        loginData.pubCertPwd = "coqjqtls!2"
//                        loginData.showLoginView = false
//                        eBESTAPI.login(self, loginData: loginData)
//                        
//                    }
//                    
//                    else
//                    {
//                        if loginData.showLoginView
//                        {
//                            //1. 공인인증 로그인 화면
//                            eBESTAPI.login(self, loginData: loginData)
//                        }
//                        else
//                        {
//                            //2. 인증서 가져오기
//                            eBESTAPI.copyPubCert(self, handle: m_apihandle)
//                        }
//                    }
//                }
//                //모의투자서버 로그인
//                else
//                {
//                    loginData.motuUserId = "ghjeong"
//                    loginData.motuUserPwd = "ahdml12"
//                    loginData.showLoginView = false
//                    eBESTAPI.login(self, loginData: loginData)
//                }
//            
//            }
//        }
//    }
//    
//    
//    // API framework에서 호출되는 이벤트
//    func onReceiveData(_ data: ReceiveData!) {
//        
//    }
//    
//    // tr 요청 결과 메시지
//    func onReceiveMessage(_ msg: ReceiveMessage!) {
//        resultLabel.text = msg.message
//    }
//    
//    func onReceiveError(_ msg: ReceiveMessage!) {
//        resultLabel.text = msg.message
//    }
//    
//    func onReleaseData(_ rqID: Int, code: String!) {
//        
//    }
//    
//    func onTimeOut(_ rqID: Int, code: String!) {
//        resultLabel.text = "onTimeOut : rqID = \(rqID) code = \(String(describing: code))"
//    }
//    
//    func onReceiveRealData(_ bcCode: String!, key: String!, data: Data!) {
//        
//    }
//    
//    // 로그인 결과 응답
//    func onLoginResult(_ result: LOGIN_MSG!) {
//        print(result.rsltMsg.msg)
//        resultLabel.text = result.rsltMsg.msg
//        
//        SetLoginStateText()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        //현재 view에서 요청했던 모든 실시간을 중지하고 해당 view에 대한 정보를 삭제한다.
//        //반드시 view가 사라질때 아래 api 함수를 호출해 줘야 한다.
//        eBESTAPI.deinitView(m_apihandle)
//    }
//    
///*
//    // API가 종료 이벤트
//    func OnDisconnect() {
//        print( "OnDisconnect" )
//        SetLoginStateText()
//    }
//    
//    // API 자동연결 이벤트
//    // 총 10회 자동연결을 진행하고 그 이후는 API가 종료된다.
//    func OnRetryConnnect(count: Int) {
//        print( "OnRetryConnnect : \(count)" )
//        resultLabel.text = String("자동연결 진행 회수 : \(count)")
//    }
// */
//}
//
//extension UIViewController {
//
//func showToast(message : String) {
//    
//    let width = self.view.frame.size.width - 50
//
//    let toastLabel = UILabel(frame: CGRect(x: 25, y: self.view.frame.size.height-70, width: width, height: 35))
//    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//    toastLabel.textColor = UIColor.white
//    //toastLabel.font = font
//    toastLabel.textAlignment = .center;
//    toastLabel.text = message
//    toastLabel.alpha = 1.0
//    toastLabel.layer.cornerRadius = 10;
//    toastLabel.clipsToBounds  =  true
//    self.view.addSubview(toastLabel)
//    UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveLinear, animations: {
//         toastLabel.alpha = 0.0
//    }, completion: {(isCompleted) in
//        toastLabel.removeFromSuperview()
//    })
//} }
//
