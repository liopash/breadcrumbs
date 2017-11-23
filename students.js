const students = [
  {
    name: "Anna",
    sex: "f",
    grades: [4.5, 3.5, 4]
  },
  {
    name: "Dennis",
    sex: "m",
    country: "Germany",
    grades: [5, 1.5, 4]
  },
  {
    name: "Martha",
    sex: "f",
    grades: [5, 4, 2.5, 3]
  },
  {
    name: "Brock",
    sex: "m",
    grades: [4, 3, 2]
  }
];
/*/ Compute female student results
const femaleStudentsResults = [];
for (const student of students) {
  if (student.sex === "f") {
    let gradesSum = 0;
    for (const grade of student.grades) {
      gradesSum += grade;
    }
    const averageGrade = gradesSum / student.grades.length;
    femaleStudentsResults.push({
      name: student.name,
      avgGrade: averageGrade
    });
  }
}
*/

/* const femaleStudentsResults = students.filter(x => x.sex == 'm').
                              map( student => 
                              student.name + ", AvgGrades: " +  
                                student.grades.reduce((x,y) => x + y)
                              )
*/

const femaleStudentsResults = students
                              .map( x => {
                                let obj = {};
                                obj['avgGrades'] = x.grades.reduce((x,y) => x + y) / x.grades.length;
                                obj['name'] = x.name;
                                return obj;                            
                              })

console.log(femaleStudentsResults);
