# Schema Explanation

---

# Students Table

## Purpose
The `students` table stores the personal and academic details of students registered in the CodeJudge platform.

## Important Columns
- `student_id` → Primary key used to uniquely identify each student.
- `roll_number` → Unique academic roll number assigned to students.
- `batch_id` → Foreign key linking students to their academic batch.
- `email` → Unique email address used for communication and login purposes.
- `enrollment_status` → Indicates the current academic status of the student.

## Relationships
- Connected to `batches` using `batch_id`.
- Connected to `enrollments` using `student_id`.
- Connected to `submissions` using `student_id`.
- Connected to `attendance` using `student_id`.

## Constraints
- `student_id` is the primary key.
- `roll_number` must be unique.
- `email` must be unique and cannot be NULL.
- `batch_id` references `batches(batch_id)`.

---

# Batches Table

## Purpose
The `batches` table stores information about academic batches and programs offered in the institution.

## Important Columns
- `batch_id` → Primary key for batch identification.
- `batch_name` → Name or code representing the batch.
- `program_name` → Academic program associated with the batch.
- `start_year` → Year in which the batch started.
- `end_year` → Year in which the batch is expected to complete.
- `batch_status` → Current status of the batch.

## Relationships
- One batch can contain multiple students.
- Connected to `students` using `batch_id`.

## Constraints
- `batch_id` is the primary key.
- `batch_status` accepts controlled values such as Active or Completed.

---

# Courses Table

## Purpose
The `courses` table stores details about courses available in the CodeJudge learning platform.

## Important Columns
- `course_id` → Primary key for each course.
- `course_code` → Unique code assigned to each course.
- `course_name` → Official course title.
- `credits` → Number of credits assigned to the course.

## Relationships
- Connected to `enrollments` using `course_id`.
- Connected to `problems` using `course_id`.
- Connected to `sessions` using `course_id`.

## Constraints
- `course_id` is the primary key.
- `course_code` must be unique.
- `credits` must be greater than zero.

---

# Problems Table

## Purpose
The `problems` table stores coding problems used in assignments, contests, and practice sessions.

## Important Columns
- `problem_id` → Primary key for each coding problem.
- `course_id` → Foreign key linking the problem to a course.
- `problem_code` → Unique identifier for coding problems.
- `title` → Name of the coding problem.
- `difficulty` → Difficulty level of the problem.
- `max_score` → Maximum score obtainable for the problem.

## Relationships
- Connected to `courses` using `course_id`.
- Connected to `submissions` using `problem_id`.
- Connected to `test_cases` using `problem_id`.
- Connected to `contest_problems` using `problem_id`.

## Constraints
- `problem_id` is the primary key.
- `problem_code` must be unique.
- `difficulty` accepts only Easy, Medium, or Hard.
- `max_score` must be greater than zero.

---

# Submissions Table

## Purpose
The `submissions` table stores source code submissions made by students for coding problems.

## Important Columns
- `submission_id` → Primary key for each submission.
- `student_id` → Foreign key referencing students.
- `problem_id` → Foreign key referencing coding problems.
- `contest_id` → Foreign key referencing contests.
- `submitted_at` → Timestamp of submission.
- `score` → Score obtained for the submission.
- `submission_status` → Result of the submission evaluation.

## Relationships
- Connected to `students` using `student_id`.
- Connected to `problems` using `problem_id`.
- Connected to `contests` using `contest_id`.
- Connected to `test_results` using `submission_id`.
- Connected to `plagiarism_flags` using `submission_id`.

## Constraints
- `submission_id` is the primary key.
- `score` cannot be negative.
- Foreign key constraints maintain referential integrity.

---

# Test_Cases Table

## Purpose
The `test_cases` table stores input and expected output data used to evaluate coding submissions.

## Important Columns
- `testcase_id` → Primary key for each test case.
- `problem_id` → Foreign key linking test cases to problems.
- `input_data` → Input provided for evaluation.
- `expected_output` → Correct expected result.

## Relationships
- Connected to `problems` using `problem_id`.
- Connected to `test_results` using `testcase_id`.

## Constraints
- `testcase_id` is the primary key.
- `problem_id` references `problems(problem_id)`.

---

# Contests Table

## Purpose
The `contests` table stores contest details conducted within the platform.

## Important Columns
- `contest_id` → Primary key for each contest.
- `contest_name` → Name of the contest.
- `start_time` → Contest start time.
- `end_time` → Contest ending time.

## Relationships
- Connected to `contest_problems` using `contest_id`.
- Connected to `submissions` using `contest_id`.

## Constraints
- `contest_id` is the primary key.
- `end_time` must be greater than `start_time`.

---

# Attendance Table

## Purpose
The `attendance` table stores attendance records for student sessions.

## Important Columns
- `attendance_id` → Primary key for attendance records.
- `session_id` → Foreign key referencing sessions.
- `student_id` → Foreign key referencing students.
- `attendance_status` → Indicates attendance state.

## Relationships
- Connected to `sessions` using `session_id`.
- Connected to `students` using `student_id`.

## Constraints
- `attendance_status` accepts Present, Absent, or Late.
- Combination of session and student should remain unique.
```
