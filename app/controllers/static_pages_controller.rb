class StaticPagesController < ApplicationController
  def home
    @study = Study.randomPromotedActive
  end

  def help
  end

  def about
  end

  def denied
  end
end
