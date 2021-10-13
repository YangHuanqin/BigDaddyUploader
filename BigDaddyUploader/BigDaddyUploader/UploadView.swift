//
//  UploadView.swift
//  BigDaddyUploader
//
//  Created by 杨焕钦 on 2021/10/9.
//

import SwiftUI
import PhotosUI


    
struct UploadView: View {
    @ObservedObject var data: MainData
    @State var userID:String
    @State var userPassword:String
    var result: [UIImage] = []
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack{
                ZStack {
                    LogoView()
                    VStack {
                        Button(action: {
                            userID = ""
                            userPassword = ""
                            self.data.jump(1)
                        }){
                            Text("返回")
                            Spacer()
                        }
                        .offset(x: 30, y: 40)
                        Spacer()
                    }
                }
                VStack{
                    ButtonView(data: data)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }else{
            HStack{
                ZStack {
                    LogoView()
                    VStack {
                        Button(action: {
                            userID = ""
                            userPassword = ""
                            self.data.jump(1)
                            
                        }){
                            Text("返回")
                            Spacer()
                        }
                        .offset(x: 25, y: 20)
                        Spacer()
                    }
                }
                HStack{
                    ButtonView(data: data)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}
struct LogoView:View {
    var body: some View{
        ZStack {
            Rectangle().foregroundColor(.black)
            Image("logo")
                .frame(width: /*@START_MENU_TOKEN@*/450.0/*@END_MENU_TOKEN@*/, height: 250.0)
        }
        
    }
}
struct ButtonView:View{
    @ObservedObject var data: MainData
    @State private var isPresented: Bool = false
    @State var pickerResult: [UIImage] = []
    @State var resultName: [String] = []
    var config: PHPickerConfiguration  {
       var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images //videos, livePhotos...
        config.selectionLimit = 0 //0 => any, set 1-2-3 for har limit
        return config
    }
    var body: some View{
        Spacer()
        Button(action: { isPresented.toggle()}) {
            Text("选择文件")
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
        }.sheet(isPresented: $isPresented) {
            PhotoPicker(configuration: self.config,
                        pickerResult: $pickerResult,
                        isPresented: $isPresented,resultName: $resultName)
        }
        Spacer()
        Button(action: {
            self.data.updateImage(pickerResult)
            self.data.updateName(resultName)
            self.data.jump(3)
        }) {
            Text("查看文件")
                .padding()
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(8)
        }
        Spacer()
        
        
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(data:MainData(),userID: "",userPassword: "")
.previewInterfaceOrientation(.portrait)
    }
}
