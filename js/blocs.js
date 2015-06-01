// Startup Scripts
$(document).ready(function()
{
	$('.hero').css('height', ($(window).height() - $('header').outerHeight()) + 'px'); // Set hero to fill page height

	$('#scroll-hero').click(function()
	{
		$('html,body').animate({scrollTop: $("#hero-bloc").height()}, 'slow');
	});
});

// Animate when visable - initialized on load for Safari bug.
$(window).load(function()
{
	animateWhenVisable();  // Activate animation when visable
});


// Window resize 
$(window).resize(function()
{
	$('.hero').css('height', ($(window).height() - $('header').outerHeight()) + 'px'); // Refresh hero height  	
}); 

// Scroll to target
function scrollToTarget(D)
{
	if(D == 1) // Top of page
	{
		D = 0;
	}
	else if(D == 2) // Bottom of page
	{
		D = $(document).height();
	}
	else // Specific Bloc
	{
		D = $(D).offset().top;
	}

	$('html,body').animate({scrollTop:D}, 'slow');
}

// Initial tooltips
$(function()
{
  $('[data-toggle="tooltip"]').tooltip()
})


// Animate when visable
function animateWhenVisable()
{
	$('.animated').removeClass('animated').addClass('hideMe'); // replace animated with hide
	
	inViewCheck(); // Initail check on page load
	
	$(window).scroll(function()
	{		
		inViewCheck(); // Check object visability on page scroll
		scrollToTopView(); // ScrollToTop button visability toggle
	});		
};

// Check if object is inView
function inViewCheck()
{	
	$($(".hideMe").get().reverse()).each(function(i)
	{	
		var target = jQuery(this);

		a = target.offset().top + target.height();
		b = $(window).scrollTop() + $(window).height();
		
		if (a < b) 
		{	
			
			var objectClass = target.attr('class').replace('hideMe' , 'animated');
			
			if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1) // If Firefox
			{
				target.css('visibility','hidden').removeAttr('class');
				setTimeout(function(){target.attr('class',objectClass).css('visibility','visable');},0.1);
			}
			else
			{
				target.attr('class',objectClass)
			}			
		}
	});
};

// ScrollToTop button toggle
function scrollToTopView()
{
	if($(window).scrollTop() > $(window).height()/3)
	{	
		if(!$('.scrollToTop').hasClass('showScrollTop'))
		{
			$('.scrollToTop').addClass('showScrollTop');
		}	
	}
	else
	{
		$('.scrollToTop').removeClass('showScrollTop');
	}
};