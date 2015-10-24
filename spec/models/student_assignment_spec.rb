require 'rails_helper'

RSpec.describe StudentAssignment, type: :model do
  it { should belong_to(:assignment) }
  it { should belong_to(:student) }

  it 'has a valid factory' do
    expect(FactoryGirl.build(:student_assignment)).to be_valid
  end

  describe '#due_for_course' do
    it 'returns the correct student_assignment' do
      @course = FactoryGirl.create(:course)
      @student = FactoryGirl.create(:student)
      @enrollment = FactoryGirl.create(:enrollment)
      @assignment = FactoryGirl.create(:assignment)
      @student_assignment = FactoryGirl.create(:student_assignment)
      expect(StudentAssignment.due_for_course(@student, @course.id).reload).to eq([@student_assignment])
    end
  end

  describe '#due_for_time' do
    context 'time == overdue' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, due_date: Date.yesterday)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'overdue').reload).to eq([@student_assignment])
      end
    end

    context 'time == today' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, due_date: Date.today)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'today').reload).to eq([@student_assignment])
      end
    end

    context 'time == tomorrow' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, due_date: Date.tomorrow)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'tomorrow').reload).to eq([@student_assignment])
      end
    end

    context 'time == this_week' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, due_date: Date.today.end_of_week)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'this_week').reload).to eq([@student_assignment])
      end
    end

    context 'next_2_weeks' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, due_date: Date.today.end_of_week + 7.days)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'next_2_weeks').reload).to eq([@student_assignment])
      end
    end

    context 'time == all' do
      it 'returns the correct student_assignment' do
        @course = FactoryGirl.create(:course)
        @student = FactoryGirl.create(:student)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment)
        @student_assignment = FactoryGirl.create(:student_assignment)
        expect(StudentAssignment.due_for_time(@student, 'all').reload).to eq([@student_assignment])
      end
    end
  end
end
