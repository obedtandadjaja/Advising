$(document).ready(function()
{
	$('.chosen-select').chosen();

	$('#name_search').click(function()
	{
		var chosen = document.getElementById('.chosen-select');
		var user_id = chosen.options[chosen.selectedIndex].value;
		document.getElementById("name_search").href="users_courses/"+user_id;
	});
})