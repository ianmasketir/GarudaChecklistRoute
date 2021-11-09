$(document).ready(function(){
	toggleDatepicker();
});

/// CONTROL FUNCTION
$("textarea.input-control.text-input[rows='1']").on("focus blur keyup", function(){
	var paddingTop = $(this).css("padding-top").replace("px",""), paddingBottom = $(this).css("padding-bottom").replace("px","");
	$(this).css("height", "18px");
	$(this).css("height",(this.scrollHeight - paddingTop - paddingBottom) + "px"); 
});
$(".btn-toggleDropdown").click(function(){
	$(this).parents(".input-control-wrapper").find($(".dropdown ~ .drop-menu")).toggleClass("hidden");
});
$(".dropdown .textbox").click(function(){
	$(this).parents(".dropdown").find($(".btn-toggleDropdown")).click();
});
$(".dropdown .textbox").on("keyup", function(){
	$(this).val("");
});
$(".drop-menu a").click(function(){
	$(".drop-menu a").removeClass("selected");
	var value = $(this).find("span").text();
	if(value.length > 0) {
		$(this).parents(".input-control-wrapper").find($(".input-control-body .textbox")).val(value);
		$(this).addClass("selected");
	}
	else {
		$(this).parents(".input-control-wrapper").find($(".input-control-body .textbox")).val("");
	}
	$(".dropdown ~ .drop-menu").addClass("hidden");
});
$(".radio-wrapper a").click(function(){
	$(this).parent().parent().find($(".radio-wrapper")).removeClass("checked");
	$(this).parent().parent().find("i").attr("class", "far fa-circle");
	$(this).parent().addClass("checked");
	$(this).find("i").attr("class", "far fa-dot-circle");
	var value = $(this).parent().attr("value");
	if($(this).parent().hasClass("checked")){
		$(this).parents(".input-control-wrapper").find($(".input-control-value input[value='"+value+"']")).prop("checked", true);
	}
	else {
		$(this).parents(".input-control-wrapper").find($(".input-control-value input[value='"+value+"']")).prop("checked", false);
	}
})
$(".checkbox-wrapper a").click(function(){
	$(this).parent().toggleClass("checked");
	$(this).parent().find("i").toggleClass("fa-square fa-check-square");
	var name = $(this).parent().attr("name");
	if($(this).parent().hasClass("checked")){
		$(this).parents(".input-control-wrapper").find($(".input-control-value input[name='"+name+"']")).prop("checked", true);
	}
	else {
		$(this).parents(".input-control-wrapper").find($(".input-control-value input[name='"+name+"']")).prop("checked", false);
	}
})

/// PICKER
$(".popup .btn-close").click(function(){
    closePickerSearch();
});
$(".picker .btn-search").click(function(){
	$(this).parents(".input-control").addClass("active");
	$(this).parents(".picker").addClass("active");
    $(".popupManager, .popup.picker-search").show();
    if($(this).parents(".picker").hasClass("multiple")){
        $(".popup.picker-search").addClass("multiple");
  }
});
$(".popup-footer .btn-submit").click(function(){
	pickerResult();
	closePickerSearch();
});
$(".picker-search .grid-content-table tr").click(function(){
	$(".picker-search .grid-content-table tr").removeClass("selected");
	$(this).addClass("selected");
	if($(this).parents(".picker-search").hasClass("multiple") == false){
		$("<span>"+$(this).find(".runtime-list-item").text()+"</span>").appendTo($(".picker-search .choice-result"));
  }
});


function toggleDatepicker() {
	//need jquery-ui.js
	$(".picker .datepicker").datepicker();
	$(".btn-pickerDate").click(function(){
		$(this).parents(".picker").find(".datepicker").focus();
	});
}
function pickerResult(){
    $(".picker.active .input-control-body input").val("");
	$(".popup-body .choice-result span").each(function(){
        var current = $(".picker.active .input-control-body input").val();
		$(".picker.active .input-control-body input").val(current + $(this).text() + ";");
	});
}
function closePickerSearch(){
	$(".popupManager").hide();
    $(".popup-body .choice-result span").remove();
}