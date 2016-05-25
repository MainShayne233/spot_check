class ActivityInput < SimpleForm::Inputs::Base

  def input
    label = "<label><abbr title='required'>*</abbr>Activity</label>".html_safe
    input = "<input class='inline form-control small-form' type='text' name='activity[title]' id='new-activity-input'></input>".html_safe
    label + input
  end

end