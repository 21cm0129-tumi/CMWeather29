//
//  MainView.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/02/07.
//

import SwiftUI

struct MainView: View {
    
    // 配列にして都市名を管理
    let cityName = [
        "tokyo","saitama","chiba","utsunomiya","maebashi","mito","yokohama"
    ]
    
    @ObservedObject var viewModel = CityWeatherViewModel()
    @State var isShowCityWeatherView = false
    
//    init(){
//        do {
//            viewModel = try ViewModel()
//        } catch  {
//            print("MainView init Error")
//        }
//    }
   
    var body: some View {
        VStack{
            
            Image("map-kanto")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
            List(cityName, id: \.self){ city in

                Button{
                    viewModel.getCityWeather(selectedCityName: city)
                    isShowCityWeatherView = true

                } label: {
                    Text(city)


                }.sheet(isPresented: $isShowCityWeatherView){
                    CityWeatherView(selectedCityName: city, inputedWeather: viewModel.inputWeather)
        }

            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
