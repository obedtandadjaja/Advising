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
	// drag and drop
	function handleDragStart(e)
	{
		this.style.opacity = '0.7';
      	e.dataTransfer.setData("element_id", e.target.getAttribute('id'));
	}

	function handleDragOver(e)
	{
	    e.preventDefault();
	    return false;
	}

	function handleDragEnter(e)
	{
		this.classList.add('over');
	}

	function handleDragLeave(e)
	{
		this.classList.remove('over');
	}

	function handleDrop(e)
	{
		var element = document.getElementById(e.dataTransfer.getData('element_id'));
		var id = e.dataTransfer.getData('element_id');
		$('#'+id).find("button").css("display", "inline");

		if(e.stopPropagation) e.stopPropagation();
		if(e.target.getAttribute('class') == "panel-body board")
		{
	        $.ajax({
			    url: '/advising_ajax/'+id,
			    type: 'PUT',
			    data: { date: e.target.id },
			    dataType: "json",
			    success: function (response) {
			    	console.log(response);
			    	if(response.error_messages)
			    	{
			    		// TODO change from alert to modal
			    		// alert(response.error_messages[0]);
			    		$('.modal-title').text('Invalid Schedule');
			    		$('.modal-body').empty();
			    		var modal_text = "<ul>";
			    		$.each(response.error_messages, function(key, message)
			    		{
			    			modal_text += "<li>";
			    			modal_text += message;
			    			modal_text += "</li>";
			    		});
			    		modal_text += "</ul>";
			    		$('.modal-body').append(modal_text);
			    		$('#myModal').modal('show');
			    	}
			    	else
			    	{
			    		$.each(response.user_courses, function(key, value) {
							$hours = 0;
							$.each(value, function(key2, value2)
							{
								$hours += value2["hr_low"];
							});
							if(($hours < 12 || $hours > 18) && ($hours != 0))
							{
								$('#'+key+'_hours').html("Total Hours: <font color='red'>"+$hours+"</font>");
							}
							else
							{
								$('#'+key+'_hours').html("Total Hours: "+$hours);
							}
						});
						$.each(response.completion, function(key, value)
						{
							$.each(value, function(key2, value2)
							{
								if(value2)
								{
									$('.completion_'+key+'_'+key2).attr('id', 'completed');
								}
								else
								{
									$('.completion_'+key+'_'+key2).attr('id', 'not_completed');
								}
							});
						});
				        e.target.appendChild(element);
			    	}
			    },
			    error: function (response) {
			    	alert("Something appears to be wrong");
			    }
			});
    	}
    	else if(e.target.getAttribute('class') == "panel-body board nope")
    	{
	        e.target.appendChild(element);
    	}
    	e.preventDefault();
    	e.target.classList.remove('over');
	    return true;
	}

	function handleDragEnd(e)
	{
		this.style.opacity = '1';
		var id = e.dataTransfer.getData('element_id');
	}

	var items = document.getElementsByClassName('item');
	element = null;
	for (var i = 0; i < items.length; i++)
	{
		element = items[i];

		element.setAttribute('draggable', 'true');
		element.setAttribute('droppable', 'false');

		element.addEventListener('dragstart', handleDragStart, false);
		element.addEventListener('dragend', handleDragEnd, false);
	}

	var groups = document.getElementsByClassName('item_group');
	element = null;
	for (var i = 0; i < groups.length; i++)
	{
		element = groups[i];

		element.setAttribute('droppable', 'true');

		element.addEventListener('dragleave', handleDragLeave, false);
		element.addEventListener('dragenter', handleDragEnter, false);
		element.addEventListener('dragover', handleDragOver, false);
		element.addEventListener('drop', handleDrop, true);
	}

	var boards = document.getElementsByClassName('board');
	element = null;
	for (var i = 0; i < boards.length; i++)
	{
		element = boards[i];

		element.setAttribute('droppable', 'true');

		element.addEventListener('dragleave', handleDragLeave, false);
		element.addEventListener('dragenter', handleDragEnter, false);
		element.addEventListener('dragover', handleDragOver, false);
		element.addEventListener('drop', handleDrop, true);
	}

	// ajax for delete
	$('.remove_button').click(function()
	{
		var id = this.getAttribute('id');
		var element = this;
		$.ajax({
		    url: '/advising_ajax_delete/'+id,
		    type: 'PUT',
		    data: { course_id: id },
		    dataType: "json",
		    success: function (response) {
		    	console.log(response);
		    	if(response.error_messages)
		    	{
		    		$('.modal-title').text('Invalid Removal');
		    		$('.modal-body').empty();
		    		var modal_text = "<ul>";
		    		$.each(response.error_messages, function(key, message)
		    		{
		    			modal_text += "<li>";
		    			modal_text += message;
		    			modal_text += "</li>";
		    		});
		    		modal_text += "</ul>";
		    		$('.modal-body').append(modal_text);
		    		$('#myModal').modal('show');
		    	}
		    	else
		    	{
		    		element.parentNode.parentNode.remove();
		    		$.each(response.user_courses, function(key, value) {
						$hours = 0;
						$.each(value, function(key2, value2)
						{
							$hours += value2["hr_low"];
						});
						if(($hours < 12 || $hours > 18) && ($hours != 0))
						{
							$('#'+key+'_hours').html("Total Hours: <font color='red'>"+$hours+"</font>");
						}
						else
						{
							$('#'+key+'_hours').html("Total Hours: "+$hours);
						}
					});
					$.each(response.completion, function(key, value)
					{
						$.each(value, function(key2, value2)
						{
							if(value2)
							{
								$('.completion_'+key+'_'+key2).attr('id', 'completed');
							}
							else
							{
								$('.completion_'+key+'_'+key2).attr('id', 'not_completed');
							}
						});
					});
		    	}
		    },
		    error: function (response) {
		    	alert("Something appears to be wrong");
		    }
		});
	});
});