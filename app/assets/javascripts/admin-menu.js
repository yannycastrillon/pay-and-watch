$(function () {
  $("#nav").hover (
    function () {
      console.log("HOVER innn!!");
      $('#admin-menu', this).fadeIn("slow");
      $(this).toggleClass('open');
    },
    function () {
      console.log("HOVER outtt!!");
      $('#admin-menu', this).fadeOut("slow");
      $(this).toggleClass('open');
    }
  )
})
