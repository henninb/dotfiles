javascript:(function(){
  var url = window.location.href;
  var meetingMatch = url.match(/\/j\/([0-9]+)/);
  if(!meetingMatch){
    alert("This doesn't appear to be a valid Zoom meeting URL.");
    return;
  }
  var meetingId = meetingMatch[1];
  var pwdMatch = url.match(/pwd=([^&]+)/);
  var newUrl = "zoommtg://zoom.us/join?action=join&confno=" + meetingId;
  if(pwdMatch){
    newUrl += "&pwd=" + pwdMatch[1];
  }
  window.location.href = newUrl;
})();
