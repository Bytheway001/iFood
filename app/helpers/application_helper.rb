module ApplicationHelper
	def bootstrap_class_for flash_type
    case flash_type
    when 'success'
      "alert-success"
    when :error
      "alert-error"
    when 'alert'
      "alert-warning"
    when 'notice'
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def order_status int
    case int
    when 0
      '<i class="far fa-clock"></i> Pendiente'.html_safe
    when 1
      '<i class="far fa-clock"></i> Preparando'.html_safe
    when 2
      '<i class="fas fa-motorcycle"></i> En Camino'.html_safe
    else 
      '<i class="far fa-clock"></i> Entregado'.html_safe
    end
  end
end
