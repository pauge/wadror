module ApplicationHelper
	
	def edit_and_destroy_buttons(item)
		if signed_in?(current_user)
			edit = link_to('Edit', url_for([:edit, item]), :class => 'btn btn-primary')
			del = link_to('Destroy', item, method: :delete, data: {confirm: 'Are you sure?'}, :class => 'btn btn-danger')

			raw("#{edit} #{del}")
		end	
	end

	def round(p)
		return number_with_precision(p, precision: 1)
	end

end
