// Lets preview the uploading image into the page.

$(function(){
  $('#user_profile_photo').on('change', function(event){
    let files = event.target.files;
    let image = files[0]
    // file size
    console.log(image.size);
    let reader = new FileReader();
    reader.onload = function(file) {
      let img = new Image();
      console.log(file);
      img.src = file.target.result;
      img.width = 100;
      img.style = "1em";
      $('#target-image').html(img)
    }
    reader.readAsDataURL(image);
    console.log(files);
  })
})

$(document).ready($(function() {
	$(".home-component .video-image, .video-options").hover(
    function(event) {
      event.target.style.opacity = 0.3
      let infoLink = $(event.target).siblings().css({opacity:1})
		  console.log(infoLink);
    },
    function (event) {
      event.target.style.opacity = 1
      let infoLink = $(event.target).siblings().css({opacity:0})

      console.log(event.target);
    }

  )

}))
