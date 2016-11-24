//
//  CourseVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/23/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire

class CourseVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblTeacher: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    var courseCode: String!
    var actualCourse: Course!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCourse{

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    func UpdateLabels (course: Course){

        lblName.text = course.Name
        lblClass.text = course.Class
        lblTeacher.text = course.Teacher
        lblSchedule.text = course.Schedule


    }

    func getCourse(_ completed: @escaping DownloadComplete){

        let URL_COURSE = "\(BASE_URL)\(COURSE_BY_CODE)\("code=")\(courseCode!)"

        Alamofire.request(URL_COURSE).responseJSON {response in
            let result = response.result

            print(response, result, " -> URL: \(URL_COURSE)")

            if let dict = result.value as? Dictionary<String, AnyObject>{

                if let status = dict["status"] as? String{
                    if status == "@validCode"{
                        if let course = dict["course"] as? Dictionary<String, AnyObject>{
                            let courseFound = Course(course: course)
                            self.actualCourse = courseFound
                            print("DICT -> \(dict)")
                            self.UpdateLabels(course: self.actualCourse)
                        }

                    }
                }
            }
            completed()
        }
        
    }
    
    @IBAction func DoneBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

        
    }
    
}
