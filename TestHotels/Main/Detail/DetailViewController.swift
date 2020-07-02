import UIKit

final class DetailViewController: UIViewController {
    private var detailView: DetailView!

    private var hotel: Hotel
    private var hotelDetails: HotelDetails? = nil
    private var hotelImage: UIImage
    private let noDataText = "no data"

    private var networkManager = NetworkManager()

    init(
        hotel: Hotel,
        image: UIImage = UIImage())
    {
        self.hotel = hotel
        self.hotelImage = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        detailView = DetailView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func updateView() {
        detailView.nameLabel.text = hotelDetails?.name ?? hotel.name
        detailView.addressLabel.text = "Address: \(hotelDetails?.address ?? hotel.address)"

        if let lat = hotelDetails?.lat, let lon = hotelDetails?.lon {
            detailView.lattitudeLabel.text = "Lattitude: \(lat)"
            detailView.longtitudeLabel.text = "Longtitude: \(lon)"
        } else {
            detailView.lattitudeLabel.text = "Lattitude: \(noDataText)"
            detailView.longtitudeLabel.text = "Longtitude: \(noDataText)"
        }

        detailView.distanceLabel.text =
        "Distance from center: \(hotelDetails?.distance ?? hotel.distance)"

        detailView.starsLabel.text = "⭐️: \(hotelDetails?.stars ?? hotel.stars)"

        if let suites = hotelDetails?.suitesAvailability.joined(separator: ", ") {
            detailView.suitesAvailableLabel.text = "Suites available: " + suites
        } else {
            detailView.suitesAvailableLabel.text = "Suites available: " + hotel.suitesAvailability.joined(separator: ", ")
        }

        detailView.imageView.image = hotelImage
    }

    private func loadDetails(
        for id: String,
        completion: @escaping (HotelDetails) -> Void)
    {
        networkManager.getHotelDetails(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    private func loadImage(
        imageName: String,
        completion: @escaping (UIImage) -> Void)
    {
        networkManager.getHotelImage(imageName: imageName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    completion(UIImage())
                    print(error)
                }
            }
        }
    }

    private func loadData() {
        loadDetails(for: String(hotel.id)) { details in
            self.hotelDetails = details

            guard let name = details.imageName else {
                self.hotelImage = UIImage()
                self.updateView()
                return
            }

            self.loadImage(imageName: name) { image in
                self.hotelImage = image.imageWithoutBorder(width: 1) ?? image
                self.updateView()
            }
        }
    }
}
