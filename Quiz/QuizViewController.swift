//
//  QuizViewController.swift
//  Quiz
//
//  Created by 八幡尚希 on 2021/02/12.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizArray = [Any]()
    
    //正解数を数えるための変数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    @IBOutlet var selection1: UIButton!
    @IBOutlet var selection2: UIButton!
    @IBOutlet var selection3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizArray.append(["僕の名前は","アイアイあ","八幡","かみ",2])
        quizArray.append(["俺の髪色は","赤","黒","黄色",2])
        quizArray.append(["3+5は？","0","1","2",2])
        
        //問題文をシャッフル
        quizArray.shuffle()
        
        choiceQuiz()

    }
    
    func choiceQuiz(){
        //一時的にクイズを取り出しておく配列
        let tmpArray = quizArray[0] as! [Any]
        
        //問題文を表示
        quizTextView.text = tmpArray[0] as? String
        
        //選択肢ボタンにそれぞれの選択肢をセット
        selection1.setTitle(tmpArray[1] as? String, for: .normal)
        selection2.setTitle(tmpArray[2] as? String, for: .normal)
        selection3.setTitle(tmpArray[3] as? String, for: .normal)
    }
    
    
    
    //問題を全て解き終わったら自動で結果画面に行くようにするためにセグエを指定して画面遷移させるperformSegueToResult()メソッドを描きます。
    func performSegueToResult() {
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    
    
    //セグエを準備するときに呼ばれるメソッド//結果を次の画面に送信
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //セゲエの名前が[toResultVIew]である時
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }
    
    
    
    @IBAction func choiceAnswer(sender: UIButton){
        
        let tmpArray = quizArray[0] as! [Any]
        
        //あってるか確認(tag == 答え)
        if tmpArray[4] as! Int == sender.tag {
            correctAnswer = correctAnswer + 1
        }
        
        //今といた問題をquizArrayから取り除く
        quizArray.remove(at: 0)
        
        //といた問題数の合計があらかじめ設定していた問題数に達したら次の画面へ
        if quizArray.count == 0 {
            //俺が書いたメソッド
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    

    

}
