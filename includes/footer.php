	<!-- End of container -->
  </div>
<script src="js/script.js"></script>
<script src="vendor/bootstrap/js/popper.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="vendor/select2/select2.min.js"></script>
<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
  $(".js-pscroll").each(function(){
    var ps = new PerfectScrollbar(this);

    $(window).on("resize", function(){
      ps.update();
    })
  });
</script>
</body>
</html>
