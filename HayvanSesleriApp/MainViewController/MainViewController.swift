import UIKit

class MainViewController: UIViewController {
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let imageView = UIImageView()
    let button = UIButton()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    backgroundColor()
    }

    func setupUI() {
    label1.text = "HAYVAN SESLERİ"
    label1.textColor = UIColor(named: "firstColor") ?? UIColor.systemGreen
    label1.font = UIFont.systemFont(ofSize: 35, weight: .bold)
    label1.textAlignment = .center
    label1.numberOfLines = 0
        
    label2.text = "Hayvan Sesleri uygulamasına hoş geldiniz!\nBu uygulama, çocuğunuzun hayvan seslerini eğlenceli bir şekilde öğrenmesine yardımcı olmak için tasarlanmıştır."
    label2.textColor = UIColor.black
    label2.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    label2.textAlignment = .center
    label2.numberOfLines = 0
        
    label3.text = "Çocuğunuzun uygulamayı güvenli bir ortamda kullanmasını sağlayın. Birlikte farklı bölümleri keşfedin ve hayvanlar hakkında bilgi edinin."
    label3.textColor = UIColor.black
    label3.font = UIFont.systemFont(ofSize: 16, weight: .light)
    label3.textAlignment = .center
    label3.numberOfLines = 0
        
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "mainAnimal")
        
    button.setTitle("Öğrenmeye Başlayalım", for: .normal)
    button.backgroundColor = UIColor(named: "firstColor") ?? UIColor.systemGreen
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    button.layer.cornerRadius = 10
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    view.addSubview(label1)
    view.addSubview(label2)
    view.addSubview(label3)
    view.addSubview(imageView)
    view.addSubview(button)
        
    label1.translatesAutoresizingMaskIntoConstraints = false
    label2.translatesAutoresizingMaskIntoConstraints = false
    label3.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
        
    NSLayoutConstraint.activate([
    label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
    label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
    label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 15),
    label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
    label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 10),
    label3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    label3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
    imageView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 20),
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
    imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
    button.heightAnchor.constraint(equalToConstant: 50),
    button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45)
    ])
    }
    
    func backgroundColor() {
    view.backgroundColor = UIColor(named: "snowColor")
    }
    
    @objc func buttonTapped() {
    performSegue(withIdentifier: "toFirstVC", sender: nil)
    }
    }

