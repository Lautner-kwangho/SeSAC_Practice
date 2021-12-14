//
//  CustomButtonView.swift
//  Assignment54_LayoutOnlyCode
//
//  Created by 최광호 on 2021/12/14.
//

import UIKit
import SnapKit

class CustomButtonView: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        self.configuration = .plain()
        self.setImage(UIImage(systemName: "pencil"), for: .normal)
        self.tintColor = .white
        self.backgroundColor = .clear
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct presentableButton<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    func makeUIView(context: Context) -> UIView {
        return CustomButtonView()
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

@available(iOS 13.0, *)
struct BorderedButton_Preview: PreviewProvider {
    static var previews: some View {
        presentableButton {
            let button = CustomButtonView(frame: .zero)
            return button
        }
        .previewLayout(.fixed(width: 100, height: 100))
        .padding(-50)
    }
}
#endif
