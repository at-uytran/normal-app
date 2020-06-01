$(document).ready(function() {
  $('.video-item').on('click', function(e) {
    var link = $(e.target).closest('.video-item').data('link');
    loadVideo(link)
  })
  
  function loadVideo(url) {
    jwplayer("myPlayer").setup({
      file: url,
      height: "90%",
      width: "100%"
    });
  }

  $.ajax({
    url: "/get_m3u8",
    type: "GET",
    dataType: 'json',
    success: function(response) {
      console.log(response.data)
    },
    error: function(error){
      console.log(error);
    }
  });
})
