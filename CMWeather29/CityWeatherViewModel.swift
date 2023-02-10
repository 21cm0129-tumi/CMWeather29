//
//  ViewModel.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/02/07.
//

import SwiftUI
import Combine
import Foundation

class CityWeatherViewModel: ObservableObject{
    
    enum Status {
        case unexecuted
        case success
        case failed
    }
    
    @Published var status: Status
    @Published var isProgress = false
    
    var resultWeather: NowWeather? = nil
    var inputWeather: [CardView.Input] = []
    // var weatherUrl: URL
    var iconImage = UIImage(named: "dummy_icon")!

    
    init() {
        status = .unexecuted
    }
    
    
    func getCityWeather(selectedCityName: String){
        
        print(selectedCityName)
        
        // 都市名をURLエンコードする
        guard let keyword_encode = selectedCityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        // URLが正しくないならばエラー
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(keyword_encode)&lang=ja&appid=d4893c53bfc0350ad4a8dc611d522b7d&units=metric") else {
            print("URLが正しくありません")
            status = .failed
            return
        }
        // コンポーネントが作られなければエラー
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            //            throw NSError()
            
            print("コンポーネントが作れません")
            status = .failed
            return
        }
        
        // コンポーネントからURLが作成できなければエラー
        guard component.url != nil else {
            //            throw NSError()
            print("コンポーネントからURLを作成できません")
            status = .failed
            return
        }
        
        
        let reqURL = URLRequest(url: url)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        print("URL:")
        print(reqURL)
        print("session:")
        print(session)
        
        // リクエストをタスクとして登録
        let task = session.dataTask(with: reqURL, completionHandler: {
            
            (data, response ,error) in
            //Data? URLResponse? Error?が省略
            
            // セッションを終了
            session.finishTasksAndInvalidate()
            
            print("taskの後のdata")
            print(data!)
            
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(NowWeather.self, from: data!)
                
                print("json:")
                print(json)
                
                self.status = .success
                self.resultWeather = json
                
                
                //画面表示の準備
                
                if let cityName = json.city?.name,
                   let lists = json.list {
                    self.inputWeather.removeAll()
                    
                    for list in lists {
                        
                        if let temp = list.main?.temp,
                           let temp_min = list.main?.temp_min,
                           let temp_max = list.main?.temp_max,
                           let pop = list.pop,
                           let dt_txt = list.dt_txt,
                           
                            let list_weather = list.weather {
                            for weather in list_weather {
                                if let description = weather.description,
                                   let icon = weather.icon {
                                    
                                    //画像をネットから取ってきてUIImageにする
                                    self.iconImage = ImageManager.uiImage(from: URL(string: "http://openweathermap.org/img/w/\(icon).png")!)
                                    
                                    //inputにポイする
                                    let inputData = CardView.Input(cityName: cityName, weatherIcon: self.iconImage, weatherTitle: description, temp: temp, temp_max: temp_max, temp_min: temp_min, pop: pop, dateTime: dt_txt)
                                    self.inputWeather.append(inputData)
                                    
                                }
                            }
                        }
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.isProgress = false
                }
                
            } catch {
                print("do-catch エラー")
            }
            
        })
        
        //ダウンロード開始
        task.resume()
        
        
    }
    
}


