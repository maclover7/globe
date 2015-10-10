require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe AssignmentLoaderWorker do
  describe "#perform" do
    before do
      @course = FactoryGirl.create(:course)
      @student = FactoryGirl.create(:student)
      @enrollment = FactoryGirl.create(:enrollment)
    end

    context 'valid assignment' do
      before do
        @assignment = FactoryGirl.create(:assignment, due_date: Date.tomorrow)
      end

      it "creates a StudentAssignment" do
        expect {
          AssignmentLoaderWorker.perform_async(@course.id, @student.id) && AssignmentLoaderWorker.drain
        }.to change(StudentAssignment, :count).by(1)
      end
    end
    context 'invalid assignment' do
       before do
        @assignment = FactoryGirl.create(:assignment, due_date: Date.yesterday)
      end

      it "creates a StudentAssignment" do
        expect {
          AssignmentLoaderWorker.perform_async(@course.id, @student.id) && AssignmentLoaderWorker.drain
        }.to change(StudentAssignment, :count).by(0)
      end
    end
  end

  describe "queue" do
    before do
      @assignment = FactoryGirl.create(:assignment)
    end

    it "is added to the queue" do
      expect {
        AssignmentLoaderWorker.perform_async(@assignment.id)
      }.to change(AssignmentLoaderWorker.jobs, :size).by(1)
    end

    it "is removed from the queue when performed" do
      AssignmentLoaderWorker.jobs.clear
      expect(AssignmentLoaderWorker.jobs.size).to eq(0)
    end
  end
end
