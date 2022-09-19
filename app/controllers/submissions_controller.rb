class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = get_user
    if user.role == "teacher"
      new_submission = Submission.new(new_submission_params)
      new_submission.user_id = user.id
      if new_submission.save!
        render json: {message: "Submission created successfully"}
      else
        render json: {error: "Unable to create submission"}
      end
    else
      render json: {error: "You don't have authorized access to create a submission"}
    end
  end

  def index
    user = get_user
    if user.role ==  "student"
      assigned_submissions = Submission.all
      if assigned_submissions.present?
        render json: assigned_submissions
      else
        render json: {message: "No submissions assigned"}
      end
    elsif user.role == "teacher"
      created_submissions = Submission.where(user_id: user.id)
      if created_submissions.present?
        render json: created_submissions
      else
        render json: {message: "No submission created by you"}
      end
    else
      render json: {error: "Unprocessable entity"}
    end
  end

  private

  def new_submission_params
    params.require(:submission).permit(:subject,:title, :description, :deadline)
  end
end
