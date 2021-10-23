/** 
 * Read Only State design pattern example.
 * (c) Christian Aberger (2021) - http://www.aberger.at
 */
import produce from "immer"
import { BehaviorSubject, Observable} from "rx"

import { Model } from "./model"
import { School } from "./school/school"

const initialState: Model = {
    schools: [],
    currentSchoolId: null
}
class Store {
    private subject = new BehaviorSubject<Model>(initialState)

    set schools(schools: School[]) {
        this.next(produce(this.state, model => {
            model.schools = schools.reduce((array, school) => {
                array[school.id] = school
                return array
            }, [])
        }))
    }
    set school(school: School) {
        this.next(produce(this.state, model => {
            model.schools[school.id] = school
        }))
    }
    set currentSchoolId(id: number) {
        this.next(produce(this.state, model => {model.currentSchoolId = id}))
    }
    set state(_notAllowed: Model) {
        throw new Error("state is read only")
    }
    get state() {
        return this.subject.getValue()
    }
    get model(): Observable<Model> {
        return this.subject
    }
    private next(state: Model) {
        this.subject.onNext(state)
    }
}
export default new Store()

