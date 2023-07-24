$('#myTab a[data-bs-toggle="pill"]').on('show.bs.tab', function(e) {
  let target = $(e.target).data('bs-target')
  $(target)
    .addClass('active show')
    .siblings('.tab-pane.active')
    .removeClass('active show')
})
