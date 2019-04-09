<script type="text/javascript">
  $(document).ready(function(){
    var randomColor = Math.floor(Math.random() * 255);
    console.log(randomColor);
    $('h1').on('click', function(){
      $(this).css('color','rgb('randomColor' + , + 'randomColor' + , + 'randomColor')');
    })
  })
</script>
