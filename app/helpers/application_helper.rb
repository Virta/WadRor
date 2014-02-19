module ApplicationHelper
  def edit_and_destroy_buttons(item)
    if current_user and current_user.is_admin?
      notice = "Admin:"
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")
      del = link_to('Destroy', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
      raw("#{notice} #{edit} #{del}")
    end
  end
  
  def round(param)
    number_with_precision param, precision: 3, significant: true, strip_insignificant_zeros: true
  end
end
