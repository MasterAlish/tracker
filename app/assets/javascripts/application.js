// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.cookie
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require bootstrap
//= require jquery-hotkeys
//= require log

$(document).ready(function(){
    initTextEditorShortcuts();
    initPreviewButton();
})

function initTextEditorShortcuts(){
    var editor = $(".editor");
    editor.on('keydown',null,'ctrl+b meta+b',function(){
        wrapText($(this),"'''","'''");
        return false;
    });
    editor.on('keydown',null,'ctrl+i meta+i',function(){
        wrapText($(this),"''","''");
        return false;
    });
    initTextEditorButtons();
}

function initTextEditorButtons(){
    var editor = $(".editor_div");
    editor.find(".btn-upload").rebind('click', function(){

    })
}

function initPreviewButton(){
    $(".preview").rebind('click',function(){
        var preview = $(this);
        var toggleEditPreview=function(){
            preview.parents('form').find(".markup_result").toggleClass("hidden");
            preview.parents('form').find(".editor").toggleClass("hidden");
            preview.text(preview.text()=='Preview'?'Edit':'Preview');
        };
        if(preview.text()=='Preview'){
            $.post("/text/markup",
                {'text_for_markup':preview.parents('form').children('textarea').val()},
                function(marked_up_text){
                    preview.parents('form').find(".markup_result").html(marked_up_text);
                    toggleEditPreview();
            });}else{
            toggleEditPreview();
        }
        return false;
    });
}

function wrapText(textArea, openTag, closeTag) {
    var len = textArea.val().length;
    var start = textArea[0].selectionStart;
    var end = textArea[0].selectionEnd;
    var selectedText = textArea.val().substring(start, end);
    if(selectedText.length > 0){
        var replacement = openTag + selectedText + closeTag;
        textArea.val(textArea.val().substring(0, start) + replacement + textArea.val().substring(end, len));
    }
}

jQuery.expr[':'].regex = function(elem, index, match) {
    var matchParams = match[3].split(','),
        validLabels = /^(data|css):/,
        attr = {
            method: matchParams[0].match(validLabels) ?
                matchParams[0].split(':')[0] : 'attr',
            property: matchParams.shift().replace(validLabels,'')
        },
        regexFlags = 'ig',
        regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
    return regex.test(jQuery(elem)[attr.method](attr.property));
}