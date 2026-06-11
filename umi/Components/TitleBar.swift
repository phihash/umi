import SwiftUI

enum FeedTab {
    case explore, mine
}

struct TitleBar: View {
    @Binding var selectedTab: FeedTab

    var body: some View {
        HStack {
            tabButton(title: "流れてきた", tab: .explore)
            tabButton(title: "あなたが流したもの", tab: .mine)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }

    @ViewBuilder
    private func tabButton(title: String, tab: FeedTab) -> some View {
        let isSelected = selectedTab == tab
        Text(title)
            .font(.subheadline)
            .foregroundColor(isSelected ? .white : .orange)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Capsule().fill(isSelected ? Color.orange : Color.clear))
            .overlay(Capsule().stroke(Color.orange, lineWidth: isSelected ? 0 : 1.5))
            .onTapGesture {
                selectedTab = tab
            }
    }
}
