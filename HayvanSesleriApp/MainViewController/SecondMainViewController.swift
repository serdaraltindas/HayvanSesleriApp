import UIKit
import AVFoundation
import GoogleMobileAds

class SecondMainViewController: UIViewController, GADBannerViewDelegate {
    var animal: FirstMainViewController.Animal?
    var bannerView: GADBannerView!
    
    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    private var backButton: UIButton!
    private var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    updateUI()
    setupAudio()
    setupNavigationBar()
        
    let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
    let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
    bannerView = GADBannerView(adSize: adaptiveSize)
    bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
    bannerView.adUnitID = "ca-app-pub-3632412211355835/7168847225"
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    addBannerViewToView(bannerView)
    bannerView.delegate = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    view.addConstraints(
    [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
    NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
    ])
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
    bannerView.alpha = 0
    UIView.animate(withDuration: 1, animations: {
    bannerView.alpha = 1
    })
    addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
    print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
    print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
    print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
    print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
    print("bannerViewDidDismissScreen")
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
    }
    
    private func setupAudio() {
    guard let animal = animal, let soundURL = Bundle.main.url(forResource: animal.soundFileName, withExtension: "wav") else { return }
    do {
    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
    audioPlayer?.prepareToPlay()
    } catch {
    print("Ses dosyası yüklenirken bir hata oluştu: \(error.localizedDescription)")
    }
    }

    @objc func playSound() {
    audioPlayer?.play()
    }
        
    private func setupLayout() {
    view.backgroundColor = UIColor(named: "snowColor") // Background color
        
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.textAlignment = .center
    nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    nameLabel.backgroundColor = UIColor(named: "firstColor")
    nameLabel.textColor = .white
    nameLabel.layer.cornerRadius = 10
    nameLabel.clipsToBounds = true
    view.addSubview(nameLabel)
        
    imageView = UIImageView()
    imageView.isUserInteractionEnabled = true // Kullanıcı etkileşimini etkinleştir
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playSound)))
    view.addSubview(imageView)
        
    let instructionLabel = UILabel()
    instructionLabel.translatesAutoresizingMaskIntoConstraints = false
    instructionLabel.text = "Sihirli resme tıkla, hayvan seslerini keşfet!"
    instructionLabel.textAlignment = .center
    instructionLabel.textColor = UIColor.black
    instructionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    view.addSubview(instructionLabel)
        
    backButton = UIButton(type: .system)
    backButton.translatesAutoresizingMaskIntoConstraints = false
    backButton.setTitle("Eve Dön", for: .normal)
    backButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    backButton.backgroundColor = UIColor(named: "firstColor")
    backButton.setTitleColor(.white, for: .normal)
    backButton.layer.cornerRadius = 10
    backButton.clipsToBounds = true
    backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    view.addSubview(backButton)
        
    NSLayoutConstraint.activate([
    nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
    nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
    nameLabel.heightAnchor.constraint(equalToConstant: 50),
        
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
    imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
    instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    instructionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
    instructionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
    backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    backButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
    backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
    backButton.heightAnchor.constraint(equalToConstant: 50),
    backButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
    }
    
    private func updateUI() {
    if let animal = animal, let image = UIImage(named: animal.imageName) {
    imageView.image = image
    nameLabel.text = animal.imageName
    }
    }
    
    @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
    }
}
