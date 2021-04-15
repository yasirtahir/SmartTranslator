//
//  HistoryViewController.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 14/04/2021.
//

import UIKit
import ViewAnimator

class HistoryViewController: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDeleteAll: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    var historyList: [TranslationHistoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAnimateTableView()
    }
    
    @IBAction func OnClicked(_ sender: UIButton) {
        if sender == btnBack {
            self.navigationController?.popViewController(animated: true)
        } else if sender == btnDeleteAll {
            self.clearHistory()
        }
    }
}

// This extension is responsible for basic functionalities
extension HistoryViewController {
    func clearHistory(){
        AppUtils.showConfirmationAlertView(title: "Confirmation", message: "Are you sure, you want to delete all history? 🤔", viewController: self) { (success) in
            AppUtils.clearHistory()
            self.historyTableView.reloadData()
        }
    }
    
    func loadAnimateTableView(){
        let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        
        self.historyList.append(contentsOf: AppUtils.getTranslationHistory())
        self.historyTableView.reloadData()
        
        UIView.animate(views: self.historyTableView.visibleCells,
                animations: [fromAnimation, zoomAnimation], delay: 0.5)
    }
}

// This extension is responsible for UITableView related things
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        let entity: TranslationHistoryModel = self.historyList[indexPath.row]
        
        cell.txtLblFrom.text = entity.fromLang
        cell.txtLblFromText.text = entity.fromText
        cell.txtLblTo.text = entity.toLang
        cell.txtLblToText.text = entity.toText
        cell.txtDateTime.text = entity.dateTime
        cell.index = indexPath.row
        
        cell.setCellBackground()
        
        return cell
    }
}

