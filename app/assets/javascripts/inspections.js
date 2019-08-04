$(document).ready(function() {

  var showOnlyUnmatchedInspection = $(".inspection-switchs #showOnlyUnmatchedInspection").change(function() {
    if(showOnlyUnmatchedInspection.is(":checked")) {
      $(".matched").hide("fast");
    }
    else {
      $(".matched").show("slow");
    }
  });

  var showFinishedInspection = $(".inspection-switchs #showFinishedInspection").change(function() {
    if(showFinishedInspection.is(":checked")) {
      $(".finished").show("slow");
    }
    else {
      $(".finished").hide("fast");
    }
  });
});
