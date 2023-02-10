//
//  CardView.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/02/08.
//

import SwiftUI

struct CardView: View {
    
    let input : Input
    struct Input: Identifiable {
        var id: UUID = UUID()
        
        let cityName: String
        let weatherIcon: UIImage
        let weatherTitle: String
        let temp : Double
        let temp_max: Double
        let temp_min: Double
        let pop: Double
        let dateTime: String
    }
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack{
            
            Image(uiImage: input.weatherIcon)
                .renderingMode(.original)
                .resizable()
                .frame(width: screenWidth / 3, height: screenWidth / 3)
                .aspectRatio(contentMode: .fit)
        
            
            Text(input.dateTime)
                .font(.title2)
                
            
            HStack{
                
                Text(input.weatherTitle)
                    .font(.title)
                
                Text(String(input.temp) + "℃")
                    .font(.title)
            }
            .padding()
            
            HStack{
                
                Spacer()
                
                VStack{
                    Text("最高/最低：")
                        .font(.title2)
                    Text("降水確率：")
                        .font(.title2)
                }
           
                Spacer()
                
                VStack{
                    Text(String(input.temp_max) + "℃  /  " + String(input.temp_min) + "℃")
                        .font(.title2)
                    
                    Text(String(input.pop * 100) + "%")
                        .font(.title2)
                }
                
                Spacer()
                   
            }
            .padding()
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: CardView.Input(cityName: "東京", weatherIcon: UIImage(systemName: "04n")!, weatherTitle: "曇り", temp: 10.0, temp_max: 10.0, temp_min: 10.0, pop: 0.4, dateTime: "2000-01-01 00:00:00"))
    }
}
