

import UIKit

class RunnerCell: UITableViewCell {
    
        var idLabel = UILabel()
        var id = UILabel()
        var nameLabel = UILabel()
        var name = UILabel()
        var pbLabel = UILabel()
        var pb = UILabel()
        
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           addSubViews()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
     func addSubViews() {
        idLabel.text = "Id:"
        self.addSubview(idLabel)
        self.addSubview(id)
        nameLabel.text = "Name:"
        self.addSubview(nameLabel)
        self.addSubview(name)
        pbLabel.text = "Personal Best:"
        self.addSubview(pbLabel)
        self.addSubview(pb)
        
        
        setupFields()
    }
    func setupFields() {
           id.anchor(top: self.topAnchor, bottom: nil, left: idLabel.rightAnchor, right: nil)
           idLabel.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil)
           name.anchor(top: id.bottomAnchor, bottom: nil, left: nameLabel.rightAnchor, right: nil)
           nameLabel.anchor(top: idLabel.bottomAnchor, bottom: nil, left: self.leftAnchor, right: nil)
           pb.anchor(top: name.bottomAnchor, bottom: self.bottomAnchor, left: pbLabel.rightAnchor, right: nil)
           pbLabel.anchor(top: nameLabel.bottomAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: nil)
          
        
       }
       func setRunner(runner: Runner) {
              id.text = String(runner.id ?? 0)
              name.text = (runner.name?.elementsEqual(""))! ? "-" : runner.name
              pb.text = String(runner.pb ?? 0.0)
          }
       

}
