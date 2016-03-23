//
//   Copyright 2015 Amy Dewaal and Obed Tandadjaja
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
$(document).ready(function()
{
	$('.chosen-select').chosen({width: '100%'});
	$('#concentration_select').parent().parent().show();

	// hide concentration at first
	// $('#concentration_select').parent().parent().hide();

	var concentrations = $('#concentration_select').html();
	$('#major_select').change(function()
	{
		major = $('#major_select :selected').text();
		majors = new Array();
		$('#major_select option:selected').each(function()
		{
			majors.push($(this).html());
		});

		// for every major get the available concentrations for it and append to array
		array = new Array();
		for(i = 0; i < majors.length; i++)
		{
			array.push($(concentrations).filter("optgroup[label='"+majors[i]+"']").html());
		};

		// show concentrations if array is not empty
		if(array.length > 0)
		{
			// $('#concentration_select').parent().parent().show();
			$('#concentration_select').empty();
			for(i = 0; i < array.length; i++)
			{
				$('#concentration_select').append(array[i]);
			}
			$('#concentration_select').trigger("chosen:updated");
			// $('#concentration_select').parent().show();
		}
		else
		{
			$('#concentration_select').empty();
			$('#concentration_select').trigger("chosen:updated");
			// $('#concentration_select').parent().parent().hide();
		}
	});

});