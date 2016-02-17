$(document).ready(function()
{
    $('.row').searchable({
        searchField: '#container-search',
        selector: '.panel',
        childSelector: '.panel-heading',
        show: function( elem ) {
            elem.slideDown(100);
        },
        hide: function( elem ) {
            elem.slideUp( 100 );
        }
    });
});