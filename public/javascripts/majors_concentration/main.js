$(document).ready(function()
{
	$('#concentration_select').parent().parent().hide();
	var concentrations = $('#concentration_select').html();
	$('#major_select').change(function()
	{
		major = $('#major_select :selected').text();
		majors = new Array();
		$('#major_select option:selected').each(function()
		{
			majors.push($(this).html());
		});
		array = new Array();
		for(i = 0; i < majors.length; i++)
		{
			array.push($(concentrations).filter("optgroup[label='"+majors[i]+"']").html());
		};
		if(array.length > 0)
		{
			$('#concentration_select').parent().parent().show();
			$('#concentration_select').empty();
			for(i = 0; i < array.length; i++)
			{
				$('#concentration_select').append(array[i]);
			}
			$('#concentration_select').trigger("chosen:updated");
			$('#concentration_select').parent().show();
		}
		else
		{
			$('#concentration_select').empty();
			$('#concentration_select').trigger("chosen:updated");
			$('#concentration_select').parent().parent().hide();
		}
	});

});