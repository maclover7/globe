require "rails_helper"
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe AssignmentCreatorWorker do
  describe "#perform" do
    before do
      @course = FactoryGirl.create(:course)
      @student = FactoryGirl.create(:student)
      @enrollment = FactoryGirl.create(:enrollment)
      @assignment = FactoryGirl.create(:assignment)
    end

    it "creates a StudentAssignment" do
      expect {
        AssignmentCreatorWorker.perform_async(@assignment.id) && AssignmentCreatorWorker.drain
      }.to change(StudentAssignment, :count).by(1)
    end
  end

  describe "queue" do
    before do
      @assignment = FactoryGirl.create(:assignment)
    end

    it "is added to the queue" do
      expect {
        AssignmentCreatorWorker.perform_async(@assignment.id)
      }.to change(AssignmentCreatorWorker.jobs, :size).by(1)
    end

    it "is removed from the queue when performed" do
      AssignmentCreatorWorker.jobs.clear
      expect(AssignmentCreatorWorker.jobs.size).to eq(0)
    end
  end
end
