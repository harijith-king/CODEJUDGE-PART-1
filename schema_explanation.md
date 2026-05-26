# Students Table
Purpose:
Stores student information registered in the CodeJudge platform.

Important Columns:
- student_id → unique student identifier
- roll_number → student academic roll number
- batch_id → links student to batches table
- email → unique student email
- enrollment_status → current status of student

Relationships:
- linked with enrollments using student_id
- linked with submissions using student_id
- linked with attendance using student_id
- linked with regrade_requests using student_id
  
# Batches Table
Purpose:
Stores academic batch information.

Important Columns:
- batch_id
- batch_code
- program
- batch_status

Relationships:
- connected to students using batch_id

# Problems Table
Purpose:
Stores coding problems available in the platform.

Important Columns:
- problem_id
- course_id
- problem_code
- difficulty
- max_score

Relationships:
- connected to submissions
- connected to test_cases
- connected to contests through contest_problems
