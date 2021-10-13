//
//  ContentView.swift
//  BigDaddyUploader
//
//  Created by 杨焕钦 on 2021/10/9.
//

import SwiftUI

class MainData: ObservableObject {
    @Published var key:Int = 1 // 这是SwiftUI中的Combine框架所包含的，在所有View中可调用此数据，数据改变便可刷新View 达到跳转目的
    @Published var result:[UIImage] = []
    @Published var name:[String] = []
    func updateImage(_ prama:[UIImage]){
        self.result.append(contentsOf: prama)
    }
    func updateName(_ prama:[String]){
        self.name.append(contentsOf: prama)
    }
    
    func jump(_ prama:Int)  {
        self.key = prama
    }
}
class Images: ObservableObject{
    
}

struct ContentView: View {
    @State var userID:String = ""
    @State var userPassword:String = ""
    @ObservedObject var data = MainData()// 遵循类的继承，这里定义为@ObservedObject
    var body: some View {
        if self.data.key == 1{
             LoginView(data:data,userID: userID,userPassword: userPassword)
        }else if self.data.key == 2{
            UploadView(data:data, userID: userID,userPassword: userPassword)
        }else if self.data.key == 3{
            ImagesView(data:data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
