jQuery ->
	$('#concentration_select').parent().hide()
	concentrations = $('#concentration_select').html()
	$('#major_select').change ->
		major = $('#major_select :selected').text()
		options = $(concentrations).filter("optgroup[label='#{major}']").html()
		if options
			$('#concentration_select').html(options)
			$('#concentration_select').parent().show()
		else
			$('#concentration_select').empty()
			$('#concentration_select').parent().hide()