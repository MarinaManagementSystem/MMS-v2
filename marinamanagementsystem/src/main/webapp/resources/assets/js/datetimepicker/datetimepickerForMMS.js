/*
window.onerror = function(errorMsg) {
	$('#console').html($('#console').html()+'<br>'+errorMsg)
}*/

$('#startOfDateAndTime').datetimepicker({
	dayOfWeekStart : 1,
	lang:'en',
	format: 'd.m.Y H:i',
	formatDate: 'd.m.Y',
	formatTime: 'H:i',
	defaultDate:'01.01.<%out.print(currentYear);%>',
	defaultTime: '00:00',
	step:5,
	
	onGenerate:function(currentDateAndTime, $input){		
		document.getElementById("hiddenStartDate").value=currentDateAndTime.dateFormat('Y-m-d');
		document.getElementById("hiddenStartTime").value=currentDateAndTime.dateFormat('H:i');
		
		//alert(document.getElementById("hiddenStartDate").value);
		//alert(document.getElementById("hiddenStartTime").value);
	}
	
	/*
	onSelectDate: function(current_date,$i){
		  alert(current_date.dateFormat('Y-m-d'));
		  document.getElementById("hiddenStartOfDateAndTime").value=current_date.dateFormat('Y-m-d');
		}
	
	onSelectTime: function(current_time,$input){
		alert(current_time.dateFormat('H:i'));
	}
	*/

});
	
$('#endOfDateAndTime').datetimepicker({
	dayOfWeekStart : 1,
	lang:'en',
	format: 'd.m.Y H:i',
	formatDate: 'd.m.Y',
	formatTime: 'H:i',
	maxDate:'+1970/01/01', // today is the maximum pickable date and current date on calendar
	//maxTime:0, // now is the maximum pickable time and current time on the calendar
	step:5,
	
	onGenerate: function(currentDateAndTime, $input){
			document.getElementById("hiddenEndDate").value=currentDateAndTime.dateFormat('Y-m-d');
			document.getElementById("hiddenEndTime").value=currentDateAndTime.dateFormat('H:i');
	}
	
});
	
$('#fromTime').datetimepicker({
	datepicker:false,
	format:'H:i',
	defaultTime: '00:00',
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenFromTime").value=current_time.dateFormat('H:i');
	}

});

$('#fromDate').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	defaultDate:'01.01.<%out.print(currentYear);%>',
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenFromDate").value=current_date.dateFormat('Y-m-d');
	}

});

$('#fromDateWithMinDayLimit').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	defaultDate:'01.01.<%out.print(currentYear);%>',
	minDate:'+1970/01/01', // today is the minimum pickable date and current date on calendar
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenFromDate").value=current_date.dateFormat('Y-m-d');
	}

});

$('#toTime').datetimepicker({
	datepicker:false,
	format:'H:i',
	//maxTime:0, // now is the maximum pickable time and current time on the calendar
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenToTime").value=current_time.dateFormat('H:i');
	}

});

$('#toDate').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	maxDate:'+1970/01/01', // today is the maximum pickable date and current date on calendar
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenToDate").value=current_date.dateFormat('Y-m-d');
	}

});

$('#toDateWithoutTodayLimit').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenToDate").value=current_date.dateFormat('Y-m-d');
	}

});

$('#fromDateForPlot').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	defaultDate:'01.01.<%out.print(currentYear);%>',
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenFromDateForPlot").value=current_date.dateFormat('Y-m-d');
	}

});

$('#toDateForPlot').datetimepicker({
	timepicker:false,
	format:'d.m.Y',
	formatDate:'d.m.Y',
	maxDate:'+1970/01/01', // today is the maximum pickable date and current date on calendar
	
	onGenerate: function(current_date, $input){

		document.getElementById("hiddenToDateForPlot").value=current_date.dateFormat('Y-m-d');
	}

});

$('#fromTimeForPlot').datetimepicker({
	datepicker:false,
	format:'H:i',
	defaultTime: '00:00',
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenFromTimeForPlot").value=current_time.dateFormat('H:i');
	}

});

$('#toTimeForPlot').datetimepicker({
	datepicker:false,
	format:'H:i',
	//maxTime:0, // now is the maximum pickable time and current time on the calendar
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenToTimeForPlot").value=current_time.dateFormat('H:i');
	}

});

$('#startOfTimeForPlot').datetimepicker({
	datepicker:false,
	format:'H:i',
	defaultTime: '00:00',
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenStartOfTimeForPlot").value=current_time.dateFormat('H:i');
	}

});

$('#endOfTimeForPlot').datetimepicker({
	datepicker:false,
	format:'H:i',
	//maxTime:0, // now is the maximum pickable time and current time on the calendar
	step:5,
	
	onGenerate: function(current_time, $input){

		document.getElementById("hiddenEndOfTimeForPlot").value=current_time.dateFormat('H:i');
	}

});