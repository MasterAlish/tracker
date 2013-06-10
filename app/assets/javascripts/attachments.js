$(document).ready(function(){
   initAttachingProcess();
});

initAttachingProcess = function(){
    $(".task .attaching").click(function(){
        task_id = helpers.getTaskIdByInnerElement($(this));
        $("#attachment_task").val(task_id);
        $("#upload_dialog").dialog({
            modal:true
        });
        return false;
    })
}