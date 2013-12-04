module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def sortable(column, title=nil)
      title ||= column.titleize
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, :sort => column, :direction => direction
  end

  # returns true if on one of the items in the survey tab
  def survey_edit_tab_active?(survey_id)
    url_for == edit_survey_path(survey_id) || url_for == survey_questions_path(survey_id)
  end
end
