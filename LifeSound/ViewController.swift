//
//  ViewController.swift
//  LifeSound
//
//  Created by Ryota Katoh on 2017/07/26.
//  Copyright © 2017 Ryota Katoh. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello World")

        let healthData = HealthData()
        let isPermission = healthData.checkPermission()
        print(isPermission)


        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let date = formatter.date(from: "2017-07-25 00:00:00")

        getSteps(date: date!, callback: { (steps, error) in
            if let err = error {
                print("error: \(err)")
                return
            }

            print("steps: \(steps)")

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getSteps(date: Date, callback: @escaping ((_ steps: Int, _ error: Error?) -> Void)) {

        let healthStore = HKHealthStore()

        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: date, end: date, options: [])

        let authorizedStatus = healthStore.authorizationStatus(for: type!)


        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) in

            if let err = error {
                print("=======fuck you=======")
                print(err)
                print("======================")
                return
            }

            var steps = 0
            if (results?.count)! > 0 {
                for result in results as! [HKQuantitySample]{
                    steps += Int(result.quantity.doubleValue(for: HKUnit.count()))
                }
            }

            callback(steps, error)

        }

        if authorizedStatus == .sharingAuthorized {
            healthStore.execute(query)
        } else {
            healthStore.requestAuthorization(toShare: [type!], read: [type! ], completion: { (success, error) in
                if error != nil {
                    print("error in authorization")
                    print(error)
                    return
                }

                if success {
                    healthStore.execute(query)
                }
            })
            
            print("not authorized")
        }
    }


}

