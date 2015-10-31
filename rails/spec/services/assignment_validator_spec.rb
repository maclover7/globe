require "rails_helper"

describe AssignmentValidator do
  describe "#check" do
    before do
      @course = FactoryGirl.create(:course)
      @student = FactoryGirl.create(:student)
      FactoryGirl.create(:enrollment, course_id: @course.id, student_id: @student.id)
      @assignment1 = FactoryGirl.create(:assignment, category: "Quiz", due_date: Date.tomorrow)
      FactoryGirl.create(:student_assignment, assignment_id: @assignment1.id, student_id: @student.id)
      @assignment2 = FactoryGirl.create(:assignment, category: "Quiz", due_date: Date.tomorrow)
      FactoryGirl.create(:student_assignment, assignment_id: @assignment2.id, student_id: @student.id)
    end

    context "status code 1" do
      it "returns status code 1 if homework" do
        due_date = Date.tomorrow
        category = "Homework"
        expect(AssignmentValidator.check(@course.id, due_date, category)).to eq(1)
      end
    end

    context "status code 2" do
      xit "returns status code 2" do
        due_date = Date.tomorrow
        category = "Test"
        pending "Fix AssignmentValidator, status code 2 tests when time."
        # expect(AssignmentValidator.check(@course.id, due_date, category)).to eq(2)
      end
    end

    context "status code 3" do
      xit "returns status code 3" do
        @assignment3 = FactoryGirl.create(:assignment, category: "Quiz", due_date: Date.tomorrow)
        FactoryGirl.create(:student_assignment, assignment_id: @assignment3.id, student_id: @student.id)
        due_date = Date.tomorrow
        category = "Test"
        pending "Fix AssignmentValidator, status code 3 tests when time."
        # expect(AssignmentValidator.check(@course.id, due_date, category)).to eq(3)
      end
    end
  end
end
