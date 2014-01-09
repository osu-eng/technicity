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

  # returns true if on one of the items is selected in the survey tab
  def survey_edit_tab_active?(survey_id)
    return false if survey_id.nil?
    current_page?(edit_survey_path(survey_id)) || current_page?(survey_questions_path(survey_id))
  end

  # returns link to edit form if survey id is set, otherwise returns path for new survey form
  def new_or_edit_survey_path(study)
    study.survey_id ? edit_survey_path(study.survey_id) : new_survey_path(study_id: study.id)
  end

  def destroy_link_to(name, path, title, body)
    link_to name, path,
            :method => :delete,
            :confirm => body,
            'data-confirm-fade' => true,
            'data-confirm-title' => title,
            'data-confirm-cancel' => 'Cancel',
            'data-confirm-cancel-class' => 'btn btn-cancel',
            'data-confirm-proceed' => 'Confirm Delete',
            'data-confirm-proceed-class' => 'btn btn-danger'
  end


end
