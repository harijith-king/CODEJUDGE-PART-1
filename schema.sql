PRAGMA foreign_keys = ON;

CREATE TABLE batches (
    batch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    batch_name VARCHAR(50) NOT NULL,
    program_name VARCHAR(100) NOT NULL,
    start_year INTEGER NOT NULL,
    end_year INTEGER,
    batch_status VARCHAR(20) CHECK (
        batch_status IN ('Active', 'Completed', 'Archived')
    )
);

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    batch_id INTEGER NOT NULL,
    roll_number VARCHAR(30) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    admission_date DATE,
    enrollment_status VARCHAR(20) CHECK (
        enrollment_status IN (
            'Active',
            'Inactive',
            'Graduated',
            'Dropped'
        )
    ),
    graduation_year INTEGER,

    FOREIGN KEY (batch_id)
    REFERENCES batches(batch_id)
);

CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits > 0),
    semester INTEGER CHECK (
        semester BETWEEN 1 AND 8
    ),
    department VARCHAR(100)
);

CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    enrollment_status VARCHAR(20) CHECK (
        enrollment_status IN (
            'Enrolled',
            'Completed',
            'Dropped'
        )
    ),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id),

    UNIQUE(student_id, course_id)
);

CREATE TABLE contests (
    contest_id INTEGER PRIMARY KEY AUTOINCREMENT,
    contest_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    contest_type VARCHAR(20) CHECK (
        contest_type IN (
            'Practice',
            'Rated',
            'Internal'
        )
    ),

    CHECK (end_time > start_time)
);

CREATE TABLE problems (
    problem_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER,
    problem_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    difficulty VARCHAR(20) CHECK (
        difficulty IN (
            'Easy',
            'Medium',
            'Hard'
        )
    ),
    max_score INTEGER NOT NULL CHECK (max_score > 0),
    created_at DATETIME,
    is_active BOOLEAN DEFAULT 1,

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);

CREATE TABLE contest_problems (
    contest_problem_id INTEGER PRIMARY KEY AUTOINCREMENT,
    contest_id INTEGER NOT NULL,
    problem_id INTEGER NOT NULL,

    FOREIGN KEY (contest_id)
    REFERENCES contests(contest_id),

    FOREIGN KEY (problem_id)
    REFERENCES problems(problem_id),

    UNIQUE(contest_id, problem_id)
);

CREATE TABLE submissions (
    submission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    problem_id INTEGER NOT NULL,
    contest_id INTEGER,
    programming_language VARCHAR(50) NOT NULL,
    submitted_at DATETIME NOT NULL,
    execution_time REAL,
    memory_used REAL,
    score INTEGER CHECK (score >= 0),

    submission_status VARCHAR(30) CHECK (
        submission_status IN (
            'Accepted',
            'Wrong Answer',
            'Runtime Error',
            'Compilation Error',
            'Time Limit Exceeded'
        )
    ),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    FOREIGN KEY (problem_id)
    REFERENCES problems(problem_id),

    FOREIGN KEY (contest_id)
    REFERENCES contests(contest_id)
);

CREATE TABLE test_cases (
    testcase_id INTEGER PRIMARY KEY AUTOINCREMENT,
    problem_id INTEGER NOT NULL,
    input_data TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    points INTEGER DEFAULT 0 CHECK (points >= 0),

    FOREIGN KEY (problem_id)
    REFERENCES problems(problem_id)
);

CREATE TABLE test_results (
    result_id INTEGER PRIMARY KEY AUTOINCREMENT,
    submission_id INTEGER NOT NULL,
    testcase_id INTEGER NOT NULL,

    result_status VARCHAR(20) CHECK (
        result_status IN (
            'Passed',
            'Failed',
            'Error'
        )
    ),

    execution_time REAL,

    FOREIGN KEY (submission_id)
    REFERENCES submissions(submission_id),

    FOREIGN KEY (testcase_id)
    REFERENCES test_cases(testcase_id)
);

CREATE TABLE sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    topic VARCHAR(200) NOT NULL,
    instructor_name VARCHAR(100),

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,

    attendance_status VARCHAR(20) CHECK (
        attendance_status IN (
            'Present',
            'Absent',
            'Late'
        )
    ),

    FOREIGN KEY (session_id)
    REFERENCES sessions(session_id),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id),

    UNIQUE(session_id, student_id)
);

CREATE TABLE regrade_requests (
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    submission_id INTEGER NOT NULL,
    request_reason TEXT NOT NULL,

    request_status VARCHAR(20) CHECK (
        request_status IN (
            'Pending',
            'Approved',
            'Rejected'
        )
    ),

    requested_at DATETIME,

    FOREIGN KEY (submission_id)
    REFERENCES submissions(submission_id)
);

CREATE TABLE plagiarism_flags (
    flag_id INTEGER PRIMARY KEY AUTOINCREMENT,
    submission_id INTEGER NOT NULL,

    similarity_percentage REAL CHECK (
        similarity_percentage BETWEEN 0 AND 100
    ),

    flagged_by VARCHAR(100),
    flagged_at DATETIME,

    FOREIGN KEY (submission_id)
    REFERENCES submissions(submission_id)
);

CREATE TABLE operation_requests (
    operation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    requested_by VARCHAR(100) NOT NULL,
    operation_type VARCHAR(100) NOT NULL,
    operation_time DATETIME NOT NULL,

    operation_status VARCHAR(20) CHECK (
        operation_status IN (
            'Pending',
            'Completed',
            'Failed'
        )
    )
);