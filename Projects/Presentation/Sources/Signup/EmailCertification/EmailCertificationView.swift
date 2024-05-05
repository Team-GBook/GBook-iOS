import SwiftUI
import xquare_design_system_iOS

public struct EmailCertificationView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    public init () { }
    
    public var body: some View {
        VStack {
            Text("이메일 인증")
                .xFont(.headline(.large), weight: .bold)
                .padding(.leading, 20)
            HStack(spacing: 18) {
                ForEach(0..<4, id: \.self) { index in
                
                }
            }
        }
        .xBackButton(dismiss: dismiss)
    }
}
