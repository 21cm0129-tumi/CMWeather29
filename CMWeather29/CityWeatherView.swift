//
//  CityWethearView.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/02/07.
//

import SwiftUI

struct CityWeatherView: View {
    
    @Environment(\.dismiss) var dismiss
    

    let selectedCityName: String
    //MainViewで選択された cityname
    
    let inputedWeather : [CardView.Input]
    
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    
    
    init(selectedCityName: String, inputedWeather: [CardView.Input]) {
        self.selectedCityName = selectedCityName
        self.inputedWeather = inputedWeather

    }
    
    
    var body: some View {
        
        VStack {
            
            Text(self.selectedCityName)
                .font(.title)
            
            //FIXME: エミュレータで実行したら表示されない。。。
            List(inputedWeather){ data in
                
                CardView(input: data)

            }
            
            
            Button {
                //MainViewに戻る
                dismiss()
            } label: {
                ZStack{
                    Circle()
                        .frame(width: screenWidth / 3, height: screenWidth / 3)
                        .foregroundColor(.blue)
                    
                    Text("←back")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
            }
            
        }
        
    }
}

struct CityWethearView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(selectedCityName: "tokyo", inputedWeather: [CardView.Input(cityName: "tokyo", weatherIcon: UIImage(systemName:  "sun.max")!, weatherTitle: "お天気", temp: 0.0, temp_max: 0.0, temp_min: 0.0, pop: 0.0, dateTime: "2000-01-01 00:00:00")])
    }
}
