

import UIKit

class AddRunnerVC: UIViewController {

       var addrunnerview = AddRunnerView()
        var runnerService = RunnerService()
        var runner = Runner()
        
        override func loadView() {
            view = addrunnerview
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            isEditMode()
        }
        
        func isEditMode() {
            if(runner.id != nil) {
                addrunnerview.name.text = runner.name
                addrunnerview.pb.text = runner.pb
                addrunnerview.yob.text = String(runner.yob ?? 0.0)
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateRunner))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(createRunner))
            }
        }
        
        @objc func createRunner() {
            if(validate()) {
                runnerService.createRunner(runner: runner){ (res) in
                    switch res {
                    case .success(_):
                        NotificationCenter.default.post(name: Notification.Name("reloadNotification"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(_):
                        self.showAlert(withTitle: "Network Error",
                            withMessage: "Failed to create Runner",
                            parentController: self,
                            okBlock: {},
                            cancelBlock: nil)
                    }
                }
            }
        }
        
        @objc func updateRunner() {
            if(validate()) {
                runnerService.updateRunner(id: runner.id!, runner: runner){ (res) in
                    switch res {
                    case .success(_):
                        NotificationCenter.default.post(name: Notification.Name("reloadNotification"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(_):
                        self.showAlert(withTitle: "Network Error",
                            withMessage: "Failed to update Runner",
                            parentController: self,
                            okBlock: {},
                            cancelBlock: nil)
                    }
                }
            }
        }
        
        func validate() -> Bool {
            if(addrunnerview.name.text!.isEmpty) {
                showAlert(withTitle: "Failed to add Runner",
                    withMessage: "Name is required.",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
                return false
            }
            runner.name = addrunnerview.name.text
            if(addrunnerview.pb.text!.isEmpty) {
                showAlert(withTitle: "Failed to add Runner",
                    withMessage: "PersonalBesy is required.",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
                return false
            }
            runner.pb = addrunnerview.pb.text
            if(addrunnerview.yob.text!.isEmpty) {
                showAlert(withTitle: "Failed to add Runner",
                    withMessage: "Year of birth is required.",
                    parentController: self,
                    okBlock: {},
                    cancelBlock: nil)
                return false
            }
            runner.yob = Double(addrunnerview.yob.text ?? "0.0")
            return true
        }
        
    }
    extension UIViewController {
        func showAlert(withTitle title : String, withMessage message: String?, parentController parent : UIViewController, okBlock : @escaping () -> (), cancelBlock : (() -> ())?) {
            let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
                okBlock()
            }
            if (cancelBlock != nil) {
                let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
                    cancelBlock!()
                }
                alert.addAction(cancelAction)
            }
            alert.addAction(okAction)
            parent.present(alert, animated: true) {
            }
        }
    }
