<script language='JavaScript'>
	function askForLogout()
	{
	    if (confirm("Are you sure you want to log out?") == true) {
	    	window.location.href = "logout";
	    	return true;
	    } else {
	        return false;
	    }
	}
</script>

<script src="../resources/assets/js/device.min.js"></script>