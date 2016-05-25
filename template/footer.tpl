    </div><!-- Main content end -->
    <script src="/template/style/js/jquery-2.2.3.min.js"></script>
    <script src="/template/style/bootstrap/js/bootstrap.min.js"></script>
    <script src="/template/style/js/global.js"></script>
    <script>
  		$(document).ready(function(){
  			$('body').addClass('ready');
  			setTimeout(function(){
  				triggerLoaded();
  			}, 2000);
  		});
  		$(window).bind("load", function() {
  			triggerLoaded();
  		});
  		function triggerLoaded() {
  			$('body').addClass('loaded');
  		}
  	</script>
  </body>
</html>
