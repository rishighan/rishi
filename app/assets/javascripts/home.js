$(document).ready(function(){

    $('.post-carousel').each(function() {
    	var $nav = $('<div id="nav"></div>').insertAfter(this);
    	
    	
    	$(this).cycle({
	        fx:     'scrollRight',
	        speed:   300,
	        timeout: 0,
	        pager:   $nav
    	});
    });
 
    
 });
