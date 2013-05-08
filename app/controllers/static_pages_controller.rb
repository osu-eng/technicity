class StaticPagesController < ApplicationController
  def home
    @study = Study.randomPromotedActive
    if @study.blank?
      @study = Study.randomActive
    end
  end

  def help
  end

  def about
  end

  def denied
  end
end
