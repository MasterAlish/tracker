function initNewCommentButton() {
    return $(".new_comment_button").click(function() {
        helpers.hideAllEditors();
        $(this).parents(".task").find(".commenting").removeClass("hidden");
        helpers.hideNewTaskCreations();
        return false;
    });
}

function initQuotingProcess(){
    $(".quote>a").click(function(){
        $.cookie('saved_quote',$(this).text());
        var el = $(this).text("Quote:");
        el.after('<input type="text" class="quote_input"/>');
        el.next().focus();
        el.next().focusout(function(){
            $(this).remove();
            el.text($.cookie('saved_quote'));
        });
        el.next().bind('keypress',function(e){
            if((e.keyCode || e.which) == 13){
                var quote = parseFloat($(this).val());
                el.text($.cookie('saved_quote'));
                if(!isNaN(quote)) {
                    $.ajax({
                        url:"/tasks/helper", type: "post",
                        data:{
                            'function':'change_quote',
                            'task':helpers.getTaskIdByInnerElement($(this)),
                            'quote':quote},
                        success:function(data){
                            el.text(quote+" hours");
                            log.addLogInfo("Quote changed: "+$.cookie('saved_quote')+" >> "+el.text());
                        }
                    });
                }
                $(this).remove();
                return false;
            }
        });
        return false;
    })
}

function initSpentTimeEnteringProcess(){
    $(".task_done").click(function(){
        $(this).after('<b>Time:</b> <input type="text" class="real_time"/>');
        memory.task_done_url = $(this).attr('href');
        spent = $(this).next().next();
        spent.focus();
        spent.focusout(function(){
            $(this).prev().remove();
            $(this).remove();
        });
        spent.bind('keypress',function(e){
            if((e.keyCode || e.which) == 13){
               var time = parseFloat($(this).val());
               if(isNaN(time)){
                   spent.addClass('error');
                   return false;
               }
               $(this).prev().remove();
               $(this).remove();
               location.href = memory.task_done_url+'&time='+time;
               return false;
            }
        });
        return false;
    })
}

function initEditButton(){
    $(".editing>a").click(function(){
        helpers.hideAllEditors();
        $(this).parents('.message').children('.result').addClass('hidden');
        $(this).parents('.message').children('.prepare').removeClass('hidden');
        return false;
    })
}

var memory = {
    task_done_url: null
}

var helpers = {
    getTicketId: function(){
        return $("#ticket_id").text();
    },
    getTaskIdByInnerElement: function(el){
        return el.parents('.task').children('.content').children('input').first().val();
    },
    getCommentIdByInnerElement: function(el){
        return el.parents('.message').children('input').first().val();
    },
    hideAllUpdatingCommentsAndShowComments:function(){
        $(".text.prepare").addClass('hidden');
        $(".text.result").removeClass('hidden');
    },
    hideNewTaskCreations:function(){
        $(".task").each(function(){
            if ($(this).children(".content").first().children(".commenting").hasClass('hidden') && $(this).children(".content").first().children(".message").length==0){
                $(this).remove();
            }
        })
    },
    hideAllEditors: function(){
       $(".commenting").addClass('hidden');
       this.hideAllUpdatingCommentsAndShowComments();
    }
}

$(document).ready(function() {
    initNewCommentButton();
    initSpentTimeEnteringProcess();
    initQuotingProcess();
    initEditButton();
});