$(document).ready(function(){
    createNewFunctions();
    initPropertiesBehaviour();
});

function createNewFunctions(){
    (function($){
        $.fn.rebind = function(event,handler){
            $(this).unbind(event);
            $(this).bind(event,handler);
        };
    })(jQuery);
}

function initPropertiesBehaviour(){
    $(".property_name").rebind('keyup',function(){
        var label = $(this).parents('div.property').children('label').first();
        label.html($(this).val()+"<a class='btn-micro' href='#'><i class='icon-remove color'></i></a>");
        initPropertyRemoving();
    });

    var remove_last_element_of_property = function(){
        var n = $(this).parents('div.property').children('.property_fields').children("input").length;
        if(n>2){
            var field= $(this).parents('div.property').children('.property_fields').first().children("input").last();
            var name=$(this).parents('div.property').children('.property_names').first().children("input").last();
            field.next("br").remove(); field.remove();
            name.next("br").remove(); name.remove();
        }
        return false;
    }
    $(".property_remove>a").rebind('click',remove_last_element_of_property);

    propertyKeyBindings();
    initPropertyRemoving();
}

function initPropertyRemoving(){
    $(".property .btn-micro").rebind('click',function(){
        $(this).parents(".property").remove();
    });
}


function propertyKeyBindings(){
    $(".property_names input").rebind('keypress',function(e){
        if((e.keyCode || e.which) == 13){
            focus_on_next_property_field($(this));
            return false;
        }
    });

    $(".property_names input").rebind('keydown',function(e){
        if((e.keyCode || e.which) == 9){
            focus_on_next_property_field($(this));
            return false;
        }
    });

    $(".property_fields input").rebind('keypress',function(e){
        if((e.keyCode || e.which) == 13){
            new_property_name($(this));
            return false;
        }
    });

    function focus_on_next_property_field(elem){
        var pat = /\[([0-9]{1,})\]$/;
        var id = elem.attr('name').match(pat);
        var field = elem.parents('div.property').children('.property_fields').first().children("input:regex(name, \["+id+"\]$)");
        field.focus();
    }

    function new_property_name(elem){
        var pat = /\[([0-9]{1,})\]\[([0-9]{1,})\]$/;
        var div_fields =elem.parents('div.property').children('.property_fields');
        var div_names =elem.parents('div.property').children('.property_names');
        var prop_id = parseInt(div_names.first().children("input").last().attr('name').match(pat)[1]);
        var id = parseInt(div_names.first().children("input").last().attr('name').match(pat)[2])+1;
        div_names.append("<input type='text' name='property_name["+prop_id+"]["+id+"]' /> <br>");
        div_fields.append("<input type='text' name='property_value["+prop_id+"]["+id+"]' /> <br>");
        div_names.first().children("input").last().focus();
        propertyKeyBindings();
    }
}