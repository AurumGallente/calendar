$(function(){
    $('.evented').parent().closest('td').addClass('evented'); 
    $(document).on('click','.td',function(){        
        
            var id = $(this).attr('id');
            var content = 
                            $.ajax({
                                    type: "GET",
                                    dataType: "script",
                                    cache: false,
                                    url: "/events/events_by_day/"+id
                                });        
    });
    $(document).on('mouseover','.pop',function(){ 
      
           $(this).popover('show');
           var id = $(this).attr('id');
           var content = 
                            $.ajax({
                                    type: "GET",
                                    dataType: "script",
                                    cache: false,
                                    url: "/events/"+id
                                });         
    });
    
    

    

});


