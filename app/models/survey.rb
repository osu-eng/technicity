class Survey < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :description
  validates_presence_of :name
  has_many :studies
  has_many :survey_questions

  def csv_header
    question_array = Array.new
    survey_questions.each do |q|
      question_array << q.question
    end
    question_array
  end

end
