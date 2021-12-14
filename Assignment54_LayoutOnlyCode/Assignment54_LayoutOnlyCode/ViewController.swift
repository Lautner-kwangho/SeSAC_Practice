//
//  ViewController.swift
//  Assignment54_LayoutOnlyCode
//
//  Created by 최광호 on 2021/12/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }


}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct presentable: UIViewRepresentable {
    func updateUIView(_ UIView: UIView, context: UIViewRepresentableContext<presentable>) {
    }
    func makeUIView(context: Context) -> UIView {
        ViewController().view
    }
}

@available(iOS 13.0, *)
struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        presentable()
            .previewDevice("iPhone 11")
    }
}
#endif
