$(document).ready(function(){
	

	$('.post-carousel').each(function() {
	   	var $nav = $('<div id="carousel-nav"></div>').insertAfter(this);
			    	
			    	
	   	$(this).cycle({
	        fx: 'scrollRight',
			slideExpr: '.slide',
			slideResize: 0,
			speed:   300,
	        timeout: 0,
	        pager:   $nav,
		  
			pagerAnchorBuilder: function() {
		        return '<a href="#" class="activeSlide"></a>';
		    }
	   	});
	 });
        
           
        	
        

		
		//var $nav = $('<div id="hero-carousel-nav"></div>').insertAfter('#hero');
		$('#hero').cycle({
			slideExpr:'img',
			fx:'fade',
			slideResize:1,
			fit:0,
			// timeout:0,
			speed:200,
			
			after: function(slide){
				var caption = slide.attr('alt');
				console.log(caption);
			}
			// pager:$nav,
			// 		pagerAnchorBuilder: function(slide) {
			// 	        return '<a href="#" class="activeSlide">'+slide+'</a>';
			// 	    }
		})

    
 });
