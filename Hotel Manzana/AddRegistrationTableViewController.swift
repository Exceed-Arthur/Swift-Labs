//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Arthur Martinez on 9/22/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController,
   SelectRoomTypeTableViewControllerDelegate {
    func selectRoomTypeTableViewController(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }

    var registration: Registration? {
    
        guard let roomType = roomType else { return nil }
    
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkindatepicker.date
        let checkOutDate = checkoutdatepicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
    
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            wifi: hasWifi,
                            roomType: roomType)
    }
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens",
                   shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King",
                   shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite",
                    shortName: "PHS", price: 309)]
    }
    func updateRoomType() {
        
        if let roomType = roomType {
            roomDetailLabel?.text = roomType.name
        } else {
            roomDetailLabel?.text = "Not Set"
        }
    }

    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController =
           SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
    }
   
 
    @IBOutlet weak var roomDetailLabel: UILabel!
    var roomType: RoomType?
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBAction func checkoutaction(_ sender: UIDatePicker) {
        updateDateViews()
    }
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func checkinaction(_ sender: UIDatePicker) {
        updateDateViews()
    }
    @IBOutlet weak var checkoutdatepicker: UIDatePicker!
    @IBOutlet weak var checkindatepicker: UIDatePicker!
    @IBOutlet weak var checkoutdetaildatelabel: UILabel!
    @IBOutlet weak var checkindetaildatelabel: UILabel!
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        //implemented later
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // In viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkindatepicker.minimumDate = midnightToday
        checkindatepicker.date = midnightToday
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }

    // MARK: - Table view data source
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)


    override func tableView(_ tableView: UITableView,
       estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    func updateDateViews() {
        checkoutdatepicker.minimumDate = Calendar.current.date(byAdding:
           .day, value: 1, to: checkindatepicker.date)
    }
    override func tableView(_ tableView: UITableView,
       didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        tableView.reloadData()
    }
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text =
           "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text =
           "\(Int(numberOfChildrenStepper.value))"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
}
