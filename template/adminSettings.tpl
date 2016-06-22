<?php
  Authentication::lockedDownPage();
?>
<div class="panel text-center">
  <div class="panel-body">
    <div id="reindexProgressContainer" class="progress" style="display: none;">
      <div id="reindexProgressBar" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%;"></div>
    </div>
    <button id="reindexButton" class="btn btn-primary"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;<?php $t->t('Reindex music folder')?></button>
  </div>
</div>

<?php
  $javascripts[] = "
  <script type='text/javascript'>
    if (!reindexButtonClick) {
      var reindexButtonClick = $(document).on('click', '#reindexButton', function(e) {
        if (confirm('".$t->r('Please confirm reindexation of the music folder.').'\n'.$t->r('The webinterface might become unresponsive while in operation.')."')) {
          $.post(appendQueryString('/?p=adminReindexAsync', {'reindex':''}));
          if (!progressUpdater) {
            var progress = 0;
            $('#reindexButton').fadeOut();
            $('#reindexProgressContainer').fadeIn();
            var progressUpdater = setInterval(function(){
              $.get({
                url: '/download/reindexProgress.json',
                cache: false
              }).done(function(data){
                progress = data.progress;
                $('#reindexProgressBar').css('width',progress+'%');
                if (progress>=100) {
                  $('#reindexProgressContainer').fadeOut(function() {
                    $('#reindexButton').fadeIn();
                    $('#reindexProgressBar').css('width','0%');
                    alert('".$t->r('Reindexation completed!')."');
                  });
                  clearInterval(progressUpdater);
                  progressUpdater = null;
                  reindexButtonClick = null;
                }
              })
            }, 800);
          }
        }
      });
    }
  </script>";
?>
