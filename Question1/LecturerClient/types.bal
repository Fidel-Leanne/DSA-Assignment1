type Staff record {
    readonly int staffNumber;
    string staffName;
    string title;
    int officeNumber;
    CourseList[] courseList;

};

type CourseList record {
    string courseCode;
    string courseName;
    int NQFLevel;
};
 
