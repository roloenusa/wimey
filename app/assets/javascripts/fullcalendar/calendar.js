$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var url = $("#calendar").attr('class')
	
	$('#calendar').fullCalendar({
		editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 400,
        width:  200,
        slotMinutes: 30,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },
        
        // a future calendar might have many sources.        
        eventSources: [{
            url: url,
            textColor: 'white',
            ignoreTimezone: false
        }],
        
        timeFormat: '',
        dragOpacity: "0.5",
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        },
	});
});

function updateEvent(the_event) {
    // $.update(
    //   "/tasks/" + the_event.id,
    //   { event: { title: the_event.title,
    //              starts_at: "" + the_event.start,
    //              ends_at: "" + the_event.end,
    //              description: the_event.description
    //            }
    //   },
    //   function (reponse) { alert('successfully updated task.'); }
    // );
	// jQuery.post('/tasks/', { 
	// 	beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	// 	id: event.id, 
	// 	start: event.start, 
	// 	end: event.end}
	// );
	var target_url = $("#calendar").attr('class')
	var params = {
		id: the_event.id,
		user_id: the_event.user_id,
		created_by: the_event.created_by,
		title: the_event.title,
		description: the_event.description,
		status: the_event.status,
		start_date: the_event.start,
		end_date: the_event.end
	};
	$.ajax({ url: '/tasks/' + the_event.id,
	  type: 'PUT',
	  beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	  data: {task: params},
	  success: function(response) {
	    $('#someDiv').html(response);
	  }
	});
};