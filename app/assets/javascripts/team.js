function readURL(input)
{
  if (input.files && input.files[0])
  {
    var reader = new FileReader();
    reader.onload = function (e)
    {
      $('#show_logo').attr('src', e.target.result);
    }
      reader.readAsDataURL(input.files[0]);
  }
}
$('#team_logo').change(function(){
  readURL(this);
});
