import { School } from "./school/school"

export interface Model {
    readonly schools: School[]
    readonly currentSchoolId?: number
}