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

load_member_team ();

function load_member_team () {
  $('#team_leader_id').find('option').not(':selected').remove();
  leader_selected = $('#team_leader_id').find('option:selected').val();
  $('#team_user_ids').find('option:selected').each(function() {
    if($(this).val()!= leader_selected )
      $('#team_leader_id').append('<option value="' + $(this).val() + '">' + $(this).text() + '</option>');
  });
}

$('#team_user_ids').on('change', function() {
  load_member_team ();
});

$('#team_user_ids').chosen({
  allow_single_deselect: true,
  width: '82%',
  no_results_text: I18n.t("admin.users.user.not_found_user")
});

$('#emptymember').click(function () {
  $('.chosen-select option').prop('selected', false).trigger('chosen:updated');
  $('#team_leader_id').find('option').not(':selected').remove();
});
