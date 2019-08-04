$(document).ready(function() {

  $('#menuButton').on("click", function() {
    if (localStorage.getItem("close_sidebar_menu") == "false") {
      localStorage.setItem("close_sidebar_menu", true);
    } else {
      localStorage.setItem("close_sidebar_menu", false);
    }
  });

  if (localStorage.getItem("close_sidebar_menu") == "true") {
    $("#asideMenu").toggle();
    $("#menuButton .closeMenu").toggle();
    $("#menuButton .openMenu").toggle();
  }

  $(".company-identify input").on("change keyup keydown", function() {
    if($(this).val().length > 0 ) {
      $(".company-identify .btn").attr("disabled", false);
    } else {
      $(".company-identify .btn").attr("disabled", true);
    }
  });

  $(".admin-login input").on("change keyup keydown", function() {
    if($(".admin-login #admin_staff_id").val().length > 0 && $(".admin-login #admin_password").val().length > 0 ) {
      $(".admin-login .btn").attr("disabled", false);
    } else {
      $(".admin-login .btn").attr("disabled", true);
    }
  });

  $("#menuButton").on("click", function() {
    $("#asideMenu").toggle("fast");
    $("#menuButton .closeMenu").toggle();
    $("#menuButton .openMenu").toggle();
  });

  $(".aside-menu-item").on("click", function() {
    $(".aside-menu-stores").not($(this).next(".aside-menu-stores")).hide();
    $(this).next(".aside-menu-stores").toggle("fast");
  });

  checkAllCheckBox();
  $('#update_all').click(function () {
      if ($(this).prop('checked')) {
          $('.update,.onlyread,#onlyread_all').prop('checked', true)
      } else {
          $('.update').prop('checked', false)
      }
  });
  $('#onlyread_all').click(function () {
      if ($(this).prop('checked')) {
          $('.onlyread').prop('checked', true)
      } else {
          $('.onlyread,.update,#update_all').prop('checked', false)
      }
  });
  $('#admin_system_admin_true').click(function () {
      $('.adminPerm').attr({
          'disabled': false,
          readonly: true
      }).prop('checked', true);
      $('#permissionTable input[type="checkbox"]').prop('checked', true);
      $('#admin_perm').show();
      superAdminDisableCheckbox();
  });
  $('#admin_system_admin_false').click(function () {
      $('.adminPerm').attr('disabled', true);
      $('#admin_perm').hide();
      superAdminDisableCheckbox();
  });
  $('.onlyread').click(function () {
      if (!$(this).prop('checked')) {
          $(this).parents('tr').find('.update').prop('checked', false);
      }
      checkAllCheckBox();
  });
  $('.update').click(function () {
      if ($(this).prop('checked')) {
          $(this).parents('tr').find('.onlyread').prop('checked', true);
      }
      checkAllCheckBox();
  });
  superAdminDisableCheckbox();

  function superAdminDisableCheckbox() {
      if ($('#admin_system_admin_true').prop('checked')) {
          $('#permissionTable input[type="checkbox"]').css('pointer-events', 'none');
      } else {
          $('#permissionTable input[type="checkbox"]').css('pointer-events', 'unset');
      }
  }

  function checkAllCheckBox() {
      $('#update_all').prop('checked', $('.update').length == $('.update:checked').length);
      $('#onlyread_all').prop('checked', $('.onlyread').length == $('.onlyread:checked').length);
  }
});
