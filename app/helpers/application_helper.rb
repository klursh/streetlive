module ApplicationHelper
  
  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end

  def br(txt)
    return txt if txt.nil?
    h(txt).gsub(/\r\n|\r|\n/, "<br>").html_safe
  end
end
