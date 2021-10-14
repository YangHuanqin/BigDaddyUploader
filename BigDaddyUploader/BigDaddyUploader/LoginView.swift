//
//  LoginView.swift
//  BigDaddyUploader
//
//  Created by 杨焕钦 on 2021/10/9.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var data:MainData
    @State var userID:String
    @State var userPassword:String
    @State var tips:String = "请登陆"
    var gradient = Gradient(colors: [Color(.systemTeal),Color(.systemPurple)])
    var body: some View {
        if horizontalSizeClass == .compact {
                VStack {
                    Spacer()
                    Text("Big\nDaddy\nUploader").font(.largeTitle).italic().fontWeight(.heavy)
                       
                    Spacer()
                    
                    HStack {
                        Spacer()
                        TextField("账号",text: $userID).padding().border(.blue) .keyboardType(.numberPad)
                        Spacer()
                    }
                    .offset(x: 0, y: -20)
                    HStack {
                        Spacer()
                        SecureField("密码",text: $userPassword).padding().border(.purple)
                            
                        Spacer()
                    }
                    Spacer()
                    Button(action:{
                        tips = ""
                        startLoad()
                        while tips == ""{
                            if tips != ""{
                                break
                            }
                        }
                        if tips == "登陆成功"{
                            self.data.jump(2)
                        }
                    }){
                        Text("登陆").bold().frame(width: 80, height: 80).foregroundColor(.white
                        ).background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)).clipShape(Capsule())
                    }
                    Spacer()
                    Divider()
                    Text(tips)
                        .font(.title2).italic().fontWeight(.heavy)
                }.padding()
        }else{
            HStack {
                Spacer()
                Text("Big\nDaddy\nUploader").font(.largeTitle).italic().fontWeight(.heavy)
                Spacer()
                VStack{
                    HStack {
                        Spacer()
                        TextField("账号",text: $userID).padding().border(.blue) .keyboardType(.numberPad)
                        Spacer()
                    }
                    .offset(x: 0, y: -20)
                    HStack {
                        Spacer()
                        SecureField("密码",text: $userPassword).padding().border(.purple)
                            
                        Spacer()
                    }
                    Divider()
                    Text(tips)
                        .font(.title2).italic().fontWeight(.heavy)
                }.padding().offset(x: 0, y: 20)
                Spacer()
               
                Button(action:{
                    tips = ""
                    startLoad()
                    while tips == ""{
                        if tips != ""{
                            break
                        }
                    }
                    if tips == "登陆成功"{
                        self.data.jump(2)
                    }
                }){
                    Text("登陆").bold().frame(width: 80, height: 80).foregroundColor(.white
                    ).background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)).clipShape(Capsule())
                }
                Spacer()
                
            }.padding()
            
        }
    }
    
    func startLoad(){
        let url = URL(string: "http://59.77.134.5:4999/")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 4
        request.httpMethod = "POST"
        let dic = [
            "id": userID,
            "pwd": userPassword,
            "token":"SOSD"
        ]
        let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request){ data,response,error in
            if let error = error {
                self.tips = error.localizedDescription
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else{
                      self.tips = "Invalid response"
                      return
                  }
            guard let data = data else {
                self.tips = "No data"
                return
            }
            guard let user = try? JSONDecoder().decode(UserInformation.self,from: data)else{
                self.tips = "Can not parse data"
                return
            }
            self.tips = "\(user.message)"
        }
        task.resume()
        
    }
       // DispatchQueue.main.async {

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(data:MainData(),userID: "",userPassword: "")
.previewInterfaceOrientation(.portrait)
    }
}
