

import UIKit

class AddRunnerView: UIView, UITextFieldDelegate {
      var nameLabel = UILabel()
        var name = UITextField()
        var pbLabel = UILabel()
        var pb = UITextField()
        var scrollView = UIScrollView()
        var textFields: [UITextField] {
            return [name,pb]
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            self.addGestureRecognizer(tap)
            setupScrollView()
            setupFields()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        func setupFields() {
            textFields.forEach { $0.delegate = self}
            nameLabel.text = "Name: *"
            name.placeholder = "Name"
            pbLabel.text = "PersonalBest: *"
            pb.placeholder = "PersonalBest"
            
            
            setFieldConstraints()
        }
      func setFieldConstraints() {
                nameLabel.anchor(top: scrollView.topAnchor, bottom: nil, left: scrollView.leftAnchor, right: nil)
                name.anchor(top: scrollView.topAnchor, bottom: nil, left: nameLabel.rightAnchor, right: nil)
                pbLabel.anchor(top: nameLabel.bottomAnchor, bottom: scrollView.bottomAnchor, left: scrollView.leftAnchor, right: nil)
                pb.anchor(top: name.bottomAnchor, bottom: scrollView.bottomAnchor, left: pbLabel.rightAnchor, right: nil)
            }
            
            func setupScrollView() {
                self.addSubview(scrollView)
                scrollView.addSubview(nameLabel)
                scrollView.addSubview(name)
                scrollView.addSubview(pbLabel)
                scrollView.addSubview(pb)
                scrollView.contentSize.height = 2000
                scrollView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor)
            }
            
            @objc func dismissKeyboard() {
                self.endEditing(true)
            }
            
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
                    textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
                return true
            }
            
        }

    extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: 15).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: 15).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -15).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -15).isActive = true
        }
    }
    }
