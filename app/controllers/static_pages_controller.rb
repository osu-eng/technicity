class StaticPagesController < ApplicationController
  def home
    @study = Study.randomActive
  end

  def help
  end

  def about
  end

  def denied
  end
end
