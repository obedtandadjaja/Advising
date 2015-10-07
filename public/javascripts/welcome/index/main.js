$(document).ready(function()
{
	function handleDragStart(e)
	{
		this.style.opacity = '0.7';
      	e.dataTransfer.setData("Text", e.target.getAttribute('id'));
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
		if (e.stopPropagation) e.stopPropagation();
	    var element = document.getElementById(e.dataTransfer.getData('Text'));
        e.target.appendChild(element);
        e.target.classList.remove('over');
        e.preventDefault();

        $.ajax({
		    url: '/images/8',
		    type: 'PUT',
		    data: { course: course_id },
		    success: function (response) {
		    },
		    error: function (response) {
		    }
		});

	    return false;
	}

	function handleDragEnd(e)
	{
		this.style.opacity = '1';
	}

	var links = document.getElementsByClassName('item');
	element = null;
	for (var i = 0; i < links.length; i++)
	{
		element = links[i];

		element.setAttribute('draggable', 'true');

		element.addEventListener('dragstart', handleDragStart, false);
		element.addEventListener('dragend', handleDragEnd, false);
	}

	var boards = document.getElementsByClassName('board');
	element = null;
	for (var i = 0; i < boards.length; i++)
	{
		element = boards[i];

		element.addEventListener('dragleave', handleDragLeave, false);
		element.addEventListener('dragenter', handleDragEnter, false);
		element.addEventListener('dragover', handleDragOver, false);
		element.addEventListener('drop', handleDrop, false);
	}
});