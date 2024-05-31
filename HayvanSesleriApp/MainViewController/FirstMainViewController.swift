import UIKit

class FirstMainViewController: UIViewController {
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var mainStackView: UIStackView!
    
    struct Animal {
    let name: String
    let imageName: String
    let soundFileName: String
    }
    
    let animals: [Animal] = [
    Animal(name: "Lion", imageName: "Aslan", soundFileName: "aslan"),
    Animal(name: "Panda", imageName: "Panda", soundFileName: "panda"),
    Animal(name: "Elephant", imageName: "Fil", soundFileName: "fil"),
    Animal(name: "Monkey", imageName: "Maymun", soundFileName: "maymun"),
    Animal(name: "Zebra", imageName: "Zebra", soundFileName: "zebra"),
    Animal(name: "Tiger", imageName: "Kaplan", soundFileName: "kaplan"),
    Animal(name: "Penguin", imageName: "Penguen", soundFileName: "penguen"),
    Animal(name: "Flamingo", imageName: "Flamingo", soundFileName: "flamingo"),
    Animal(name: "Giraffe", imageName: "Zürafa", soundFileName: "zürafa"),
    Animal(name: "Koala", imageName: "Fok", soundFileName: "fok"),
    Animal(name: "Tiger", imageName: "Balina", soundFileName: "balina"),
    Animal(name: "Penguin", imageName: "Samur", soundFileName: "samur"),
    Animal(name: "Flamingo", imageName: "Yengeç", soundFileName: "yengeç"),
    Animal(name: "Giraffe", imageName: "Yunus", soundFileName: "yunus"),
    Animal(name: "Giraffe", imageName: "Kedi", soundFileName: "kedi"),
    Animal(name: "Giraffe", imageName: "Köpek", soundFileName: "köpek"),
    Animal(name: "Giraffe", imageName: "Fare", soundFileName: "fare"),
    Animal(name: "Koala", imageName: "Koala", soundFileName: "panda"),
    ]
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setupBackground()
    setupScrollView()
    setupMainStackView()
    setupNavigationBar()
    }
    
    private func setupNavigationBar() {
    navigationItem.title = "Hayvanlar"
    let backButton = UIBarButtonItem(
    image: UIImage(systemName: "arrow.left"),
    style: .plain,
    target: self,
    action: #selector(backButtonPressed)
    )
    navigationItem.leftBarButtonItem = backButton
    navigationController?.navigationBar.tintColor = UIColor.black
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    //ScrollView gölge kaldırmak için sakın unutma!
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    @objc func backButtonPressed() {
    self.navigationController?.popViewController(animated: true)
    }

    private func setupBackground() {
    view.backgroundColor = UIColor(named: "snowColor")
    }
    
    private func setupScrollView() {
    scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
        
    NSLayoutConstraint.activate([
    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
        
    contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(contentView)
        
    NSLayoutConstraint.activate([
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    }
    
    private func setupMainStackView() {
    mainStackView = UIStackView()
    mainStackView.axis = .vertical
    mainStackView.distribution = .fill
    mainStackView.alignment = .fill
    mainStackView.spacing = 30
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(mainStackView)

    NSLayoutConstraint.activate([
    mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
    mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
    mainStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
    ])
    createButtons()
    }
    
    func createButtons() {
    let numberOfRows = animals.count / 2 + animals.count % 2
    for i in 0..<numberOfRows {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.distribution = .fillEqually
        rowStackView.alignment = .center
        rowStackView.spacing = 20
        for j in 0..<2 {
            let index = i * 2 + j
            if index < animals.count {
                let animal = animals[index]
                let button = UIButton()
                if let image = UIImage(named: animal.imageName) {
                        button.setImage(image, for: .normal)
                }
                button.imageView?.contentMode = .scaleAspectFit
                button.clipsToBounds = true
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
                button.layer.cornerRadius = 15
                button.tag = index
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
                button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1).isActive = true
            }
        }
        mainStackView.addArrangedSubview(rowStackView)
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
    performSegue(withIdentifier: "toSecondVC", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSecondVC",
    let button = sender as? UIButton,
    let destinationVC = segue.destination as? SecondMainViewController {
    let animal = animals[button.tag]
    destinationVC.animal = animal
    }
    }
}

