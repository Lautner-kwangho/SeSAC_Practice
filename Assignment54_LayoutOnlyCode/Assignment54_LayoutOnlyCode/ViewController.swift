//
//  ViewController.swift
//  Assignment54_LayoutOnlyCode
//
//  Created by 최광호 on 2021/12/14.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {

    let songTitle = UILabel().then {
        $0.text = "Strawberry moon"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    let subSongTitle = UILabel().then {
        $0.text = "아이유"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .center
    }
    
    let mainView = UIView()
    let musicImage = UIImageView().then {
        $0.image = UIImage(named: "Sample Image")
    }
    let firstRightStackView = CustomStackView().then {
        $0.distribution = .fill
    }
    let firstLeftStackView = CustomStackView().then {
        $0.distribution = .fill
    }
    let firstButton1 = CustomButtonView()
    let firstLabel = UILabel().then {
        $0.text = "41,726"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 16)
    }
    let firstButton2 = CustomButtonView(type: .custom).then {
//        $0.layer.borderColor = UIColor.white.cgColor
//        $0.layer.borderWidth = 1
//        $0.layer.cornerRadius = 5
        $0.setImage(nil, for: .normal)
//        $0.setTitle("유사곡", for: .normal)
    }
    let firstButton3 = CustomButtonView()
    
    
    let textField = UITextView().then {
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.text = """
        달이 익어가니 서둘러 젊은 피야
        민들레 한 송이 들고
        사랑이 어지러이 떠다니는 밤이야
        날아가 사뿐히 이루렴
        팽팽한 어둠 사이로
        떠오르는 기분
        이 거대한 무중력에 혹 휘청해도
        두렵진 않을 거야
        푸르른 우리 위로
        커다란 strawberry moon, 한 스쿱
        나에게 너를 맡겨볼래, eh-oh
        바람을 세로질러
        날아오르는 기분 so cool
        삶이 어떻게 더 완벽해, ooh
        다시 마주하기 어려운 행운이야
        온몸에 심장이 뛰어
        Oh, 오히려 기꺼이 헤매고픈 밤이야
        너와 길 잃을 수 있다면
        맞잡은 서로의 손으로
        출입구를 허문
        이 무한함의 끝과 끝 또 위아래로
        비행을 떠날 거야
        푸르른 우리 위로
        커다란 strawberry moon, 한 스쿱
        나에게 너를 맡겨볼래, eh-oh
        바람을 세로질러
        날아오르는 기분 so cool
        삶이 어떻게 더 완벽해, ooh
        놀라워 이보다
        꿈같은 순간이 또 있을까? (더 있을까?)
        아마도 우리가 처음 발견한
        오늘 이 밤의 모든 것, 그 위로 날아
        푸르른 우리 위로
        커다란 strawberry moon, 한 스쿱
        세상을 가져보니 어때, eh-oh
        바람을 세로질러
        날아오르는 기분 so cool
        삶이 어떻게 더 완벽해, ooh
        """
    }
    
    
    let middleStackView = CustomStackView().then {
        $0.distribution = .fillProportionally
    }
    let middlebutton1 = CustomButtonView()
    let middleSlider = UISlider().then {
        $0.thumbTintColor = .clear
    }
    let middlebutton2 = CustomButtonView()
    
    
    let lastStackView = CustomStackView()
    let button1 = CustomButtonView().then {
        $0.setImage(UIImage(systemName: "music.note.list"), for: .normal)
    }
    let button2 = CustomButtonView().then {
        $0.setImage(UIImage(systemName: "arrow.left.to.line.compact"), for: .normal)
    }
    let button3 = CustomButtonView().then {
        $0.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    let button4 = CustomButtonView().then {
        $0.setImage(UIImage(systemName: "arrow.right.to.line.compact"), for: .normal)
    }
    let button5 = CustomButtonView().then {
        $0.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.navigationController?.isNavigationBarHidden = true
        [songTitle, subSongTitle, mainView, musicImage, firstRightStackView, firstButton1, firstLabel, firstButton2, firstButton3,  firstLeftStackView, textField, middleStackView, lastStackView].forEach {
            view.addSubview($0)
        }
        
        setTitleConstraints()
        setFirstView()
        setTextField()
        setMiddeView()
        setBottomView()
    }
    
    func setTitleConstraints() {
        songTitle.snp.makeConstraints { make in
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        subSongTitle.snp.makeConstraints { make in
            make.top.equalTo(songTitle.snp.bottom)
            make.centerX.height.equalTo(songTitle)
        }
    }
    
    func setFirstView() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(subSongTitle.snp.bottom)
            make.leading.trailing.equalTo(view).inset(40)
            make.bottom.equalTo(textField.snp.top)
        }
        
        mainView.addSubview(musicImage)
        musicImage.snp.makeConstraints { make in
            make.centerY.equalTo(mainView).offset(-20)
            make.leading.trailing.equalTo(mainView)
            make.height.equalTo(mainView).dividedBy(1.5)
        }
        
        mainView.addSubview(firstLeftStackView)
        firstLeftStackView.snp.makeConstraints { make in
            make.top.equalTo(musicImage.snp.bottom)
            make.leading.equalTo(mainView)
            make.height.equalTo(middleStackView)
        }
        
        firstLeftStackView.addArrangedSubview(firstButton1)
        firstLeftStackView.addArrangedSubview(firstLabel)
        
        firstButton1.snp.makeConstraints { make in
            make.width.equalTo(firstLeftStackView.snp.height)
        }
        firstButton1.setImage(UIImage(systemName: "heart"), for: .normal)
        
        mainView.addSubview(firstRightStackView)
        firstRightStackView.snp.makeConstraints { make in
            make.top.equalTo(musicImage.snp.bottom)
            make.trailing.equalTo(mainView)
            make.height.equalTo(middleStackView)
        }
        
        firstRightStackView.addArrangedSubview(firstButton2)
        firstRightStackView.addArrangedSubview(firstButton3)
        firstButton3.setImage(UIImage(systemName: "square.inset.filled"), for: .normal)
        
        firstButton2.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(20)
            make.centerY.equalTo(firstRightStackView)
        }
        
        let label = UILabel()
        label.text = "유사곡"
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        firstButton2.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(firstButton2).inset(10)
        }
        
        firstButton3.snp.makeConstraints { make in
            make.width.equalTo(firstLeftStackView.snp.height)
        }
    }
    
    func setTextField() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(middleStackView.snp.top)
            make.height.equalTo(lastStackView.snp.height).multipliedBy(2)
        }
    }
    
    func setMiddeView() {
        let middleSubView = [middlebutton1, middleSlider, middlebutton2]
        middleSubView.forEach {
            middleStackView.addArrangedSubview($0)
        }
        
        middlebutton1.setImage(UIImage(systemName: "repeat"), for: .normal)
        middlebutton2.setImage(UIImage(systemName: "shuffle"), for: .normal)
        
        middleStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(lastStackView.snp.top)
            make.height.equalTo(lastStackView.snp.height).dividedBy(2)
        }
        
        middleSlider.snp.makeConstraints { make in
            make.leading.equalTo(middlebutton1.snp.trailing)
            make.trailing.equalTo(middlebutton2.snp.leading)
        }
        middlebutton1.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).dividedBy(9)
        }
        middlebutton2.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).dividedBy(9)
        }
    }
    
    func setBottomView() {
        let stackViewSubView = [button1, button2, button3, button4, button5]
        
        stackViewSubView.forEach {
            lastStackView.addArrangedSubview($0)
        }
        
        lastStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }

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
