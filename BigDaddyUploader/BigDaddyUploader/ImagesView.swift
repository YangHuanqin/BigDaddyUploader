//
//  ImagesView.swift
//  BigDaddyUploader
//
//  Created by 杨焕钦 on 2021/10/10.
//

import SwiftUI

struct ImagesView: View {
    @ObservedObject var data: MainData
    @State var open:Bool = false
    @State var width:String = ""
    @State var height:String = ""
    @State var allImages: [UIImage] = []
    var body: some View {
        ScrollView{
            LazyVStack {
                    VStack {
                        HStack {
                            Button(action: {

                                self.data.jump(2)
                            }){
                                Text("返回")
                                
                                Spacer()
                            }
                        .offset(x: 10, y: 0)
                            Text("查看照片").position(x: 15,y: 10)
                            Button(action: {
                                self.open = true
                            }) {
                                Text("裁剪")
                            }
                            .offset(x: -10, y: 0)
                            .sheet(isPresented: $open) {
                                VStack {
//                                    Button(action: {
//                                        self.open = false
//                                    }){
//                                        Text("返回")
//
//                                        Spacer()
//                                    }
//                                    .offset(x: -80, y: -80)
                                    if Int(width) != nil && Int(height) != nil{
                                        Text("现在的尺寸是\(Int(width)!)*\(Int(height)!)")
                                    }
                                    else{
                                        Text("请在下方输入你想要的裁剪规格。")
                                    }
                                    Spacer()
                                    HStack {
                                        TextField("请输入宽", text: $width)
                                            .keyboardType(.numberPad)
                                    }
                                    Divider()
                                    Spacer()
                                    HStack {
                                        TextField("请输入高", text: $height)
                                            .keyboardType(.numberPad)
                                    }
                                    Divider()
                                    Button(action: {
                                        self.open = false
                                    }){
                                        Text("返回")
                                        
                                        //Spacer()
                                    }
                                    
                                   
                                    Spacer()
                                }
                                .padding(100)
                            }
                        }
                    Divider()
                    if width == "" && height == ""{
                            ForEach(0..<self.data.result.count, id: \.self) { index in
                                Image.init(uiImage: self.data.result[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Text(self.data.name[index])
                       }
                    }else if Double(width) != nil && Double(height) != nil {
                        ForEach(0..<self.data.result.count, id: \.self) { index in
                            Image.init(uiImage: self.data.result[index])
                                .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width:Double(width)!, height:Double(height)!)
                                .clipped(antialiased: true)
                            Text(self.data.name[index])
                                
                        }
                    }
                }
            }
        }
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView(data:MainData())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
