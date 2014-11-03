$('document').ready(function(){
    $("tr").on('click', function() {
        if (typeof $(this).data('link') == 'undefined') {
            return false;
        }
        window.location = $(this).data("link");
    });
});
