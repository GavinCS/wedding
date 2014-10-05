/**
 * User: gavin
 * Date: 2014/08/17
 */

function check_all(that)
{
    var guests = $('#guest_email').find('input[type=checkbox]')

    if(that.checked) {
        guests.each(function() {
            this.checked = true;
        });
    } else {
        guests.each(function() {
            this.checked = false;
        });
    }

}

function template_change()
{
    $.ajax({
        dataType: "json",
        url: "/admin/guests/ajax-get-guests/",
        data: 'mail_template=' + $('#mail_template').val(),
        success: function (resp) {
            var html ='';
            $.each(resp, function(index, guest){
                html += '<li>';
                html += '<input id="guest_ids_' + index +'" name="guest_ids[]" type="checkbox" value="'+ guest.id +'">';
                html += '<label for="guest_ids_' + index +'">' + guest.name + ': ' + guest.email + '</label>';
                html += '</li>';
            });

            $('#guest_email').html(html);
        }
    });
}


$(document).ready(function(){

    var checkAll = $('#check_all');
    checkAll.on('click', function(e) {

        check_all(this);
    });
});