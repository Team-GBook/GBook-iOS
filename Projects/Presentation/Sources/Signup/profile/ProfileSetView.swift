import SwiftUI
import xquare_design_system_iOS

public struct ProfileSetView: View {
    @State var text: String = ""
    @Environment(\.dismiss) var dismiss: DismissAction

    public init () { }
    public var body: some View {
        HStack {
            Text("프로필 설정")
                .xFont(.headline(.large), weight: .bold)
            Spacer()
        }
        .padding(.leading, 20)
        VStack(spacing: 10) {
            Button {
                
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .foregroundColor(.gray)
            }
            XTextField("이름(닉네임)", text: $text)
        }
        .padding(.horizontal, 20)
        Spacer()
        GBButton(title: "회원가입") {
            
        }
        .xBackButton(dismiss: dismiss)
    }
}
