function initNewCommentButton() {
    return $(".new_comment_button").click(function() {
        window.current_markup_result = $(this).parents(".task").find(".markup_result");
        $(".commenting").addClass('hidden');
        $(this).parents(".task").find(".commenting").removeClass("hidden");
        return false;
    });
};

$(document).ready(function() {
    return initNewCommentButton();
});