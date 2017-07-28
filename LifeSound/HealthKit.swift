//
//  HealthKit.swift
//  LifeSound
//
//  Created by Ryota Katoh on 2017/07/26.
//  Copyright © 2017 Ryota Katoh. All rights reserved.
//

import Foundation
import HealthKit

class HealthData: NSObject {

    var storage = HKHealthStore()
    var permitted = false

    override init() {
        super.init()
        permitted = checkPermission()
    }

    func checkPermission() -> Bool {
        var enabled = false

        if HKHealthStore.isHealthDataAvailable() {

            enabled = true

        }

        return enabled
    }


//    func getSteps(date: Date, callback: @escaping ((_ steps: Int, _ error: Error?) -> Void)) {
//
//
//        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
//        let predicate = HKQuery.predicateForSamples(withStart: date, end: date, options: [])
//
//        let authorizedStatus = storage.authorizationStatus(for: type!)
//
//
//        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) in
//
//            if let err = error {
//                print("=======fuck you=======")
//                print(err)
//                print("======================")
//                return
//            }
//
//            var steps = 0
//            if (results?.count)! > 0 {
//                for result in results as! [HKQuantitySample]{
//                    steps += Int(result.quantity.doubleValue(for: HKUnit.count()))
//                }
//            }
//
//            callback(steps, error)
//
//        }
//
//        if authorizedStatus == .sharingAuthorized {
//            storage.execute(query)
//        } else {
//            storage.requestAuthorization(toShare: [type!], read: [type! ], completion: { (success, error) in
//                if error != nil {
//                    print("error in authorization")
//                    print(error)
//                    return
//                }
//
//                if success {
//                    self.storage.execute(query)
//                }
//            })
//
//            print("not authorized")
//        }
//
//
//
//    }

}
