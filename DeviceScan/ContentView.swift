//
//  ContentView.swift
//  DeviceScan
//
//  Created by Abdul Rahim on 29/05/22.
//

import SwiftUI
import DeviceGuru

struct ContentView: View {

    private let guru = DeviceGuruImplementation()

    private var name: Hardware { guru.hardware }
    private var code: String { UIDevice.current.getCPUName() }
    private var cpuDetail: String { UIDevice.current.getCPUSpeed() }
    private var description: String? { try? guru.hardwareDescription() }
    private var deviceVersion: DeviceVersion? { try? guru.deviceVersion() }
    @State private var showDetails = false

    // MARK:- View & properties
    
    var body: some View {
        // adding button for scanning the device
        Button(action: {
            showDetails.toggle()
        }) {
            Text("Scan Device")
                .padding(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 2.0)
                        .shadow(color: .blue, radius: 10.0)
                )
        }
        
        // vstack for detail view
        VStack {
            if showDetails {  ///  checking the showDetail property for detail
                Text(description ?? "This Device")
                    .font(.title3).padding(.bottom)
                
                /// hstack for the heading/titles
                HStack {
                    VStack {
                        headline("Device Name")
                        headline("Device Chipset")
                        headline("Device CPU")
                        headline("Device Version")
                    }
                    
                    /// vstack for the values
                    VStack {
                        value(String(describing: name))
                        value(code)
                        value(String(describing: cpuDetail))
                        value("\(String(describing: deviceVersion!.major)),\(deviceVersion!.minor)")
                    }
                }
            }
        }.padding()
        .background(Color(white: 0.92, opacity: 1))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
        
        // adding button for saving detail to document
        let fileData = """
                        \(value(String(describing: name)))
                        \(value(code))
                        \(value(String(describing: cpuDetail)))
                        \(value("\(String(describing: deviceVersion!.major)),\(deviceVersion!.minor)"))
        """
        if showDetails{
            Button(action: {
                FileManager.shared.save(text: fileData, withFileName: "file\(Int.random(in: 0...1000))")
            }) {
                Text("Save to File")
                    .padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                            .shadow(color: .orange, radius: 10.0)
                    )
            }
        }
    }

    // adjusting the value alignment here
    private func value(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14))
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading)
    }

    // adjusting the headline alignment here for multiline text
    private func headline(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .multilineTextAlignment(.trailing)
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .trailing)
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
