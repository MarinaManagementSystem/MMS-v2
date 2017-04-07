// JavaScript Document
/**
 * This javascript file checks for the brower/browser tab action.
 * It is based on the file menstioned by Daniel Melo.
 * Reference: http://stackoverflow.com/questions/1921941/close-kill-the-session-when-the-browser-or-tab-is-closed     * http://eureka.ykyuen.info/2011/02/22/jquery-javascript-capture-the-browser-or-tab-closed-event/
 */
var validNavigation = false;

function endSession() {
    // Browser or broswer tab is closed
    // Do some your php function to destroy the session
	
    $.get('logout.jsp'); // here
    
    /* 
    acording to
    http://stackoverflow.com/questions/5081025/php-session-fixation-hijacking
    <?php
    function destroySession() {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
    session_destroy();
        }
    ?>
    */
}

function wireUpEvents() {
    /*
     * For a list of events that triggers onbeforeunload on IE
     * check http://msdn.microsoft.com/en-us/library/ms536907(VS.85).aspx
     */
	if(location.pathname.substring(location.pathname.lastIndexOf("/") + 1) != 'login.jsp' && location.pathname.substring(location.pathname.lastIndexOf("/") + 1) != 'logout.jsp')
	{
	    window.onbeforeunload = function () {
	    	
	        if (!validNavigation) {
	        	//return "Do you really want to go away? You will be logged out if you proceed.";
	        	//return "Please logout before you leave!";
	            endSession();
	        }
	    }
	}

    // Attach the event keypress to exclude the F5 refresh
    $('document').bind('keypress', function (e) {
        if (e.keyCode == 116) {
            validNavigation = true;
        }
    });

    // Attach the event click for all links in the page
    $("a").bind("click", function () {
        validNavigation = true;
    });

    // Attach the event submit for all forms in the page
    $("form").bind("submit", function () {
        validNavigation = true;
    });

    // Attach the event click for all inputs in the page
    $("input[type=submit]").bind("click", function () {
        validNavigation = true;
    });

}

// Wire up the events as soon as the DOM tree is ready
$(document).ready(function () {
    wireUpEvents();
});