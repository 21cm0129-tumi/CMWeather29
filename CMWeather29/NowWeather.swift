//
//  Weather.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/01/20.
//

import Foundation

struct NowWeather: Decodable{
    
    let list: [List]?
    struct List: Decodable {
        let dt: Int?
        
        let main: Main?
        struct Main: Decodable{
            let temp: Double?
            let temp_min: Double?
            let temp_max: Double?
        }
        
        let weather: [Weather]?
        struct Weather: Decodable{
            let id: Int?
            let main: String?
            let description: String?
            let icon: String?
        }
        let pop: Double? //降水確率 パラメータの値は 0 ～ 1 の間で変化します。0 は 0%、1 は 100% です。
        let dt_txt: String? //"2023-01-20 06:00:00"　こういうデータが取れる
    }
    
    let city: City?
    struct City: Decodable{
        let name: String?
    }
    
}
