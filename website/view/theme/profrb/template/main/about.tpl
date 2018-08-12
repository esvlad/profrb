<section class="sect <?=$sect_class;?>">
  <div class="wrapper">
    <div class="content">
      <h2><?=$sect_title;?></h2>
      <div class="row_block clearfix">
        <?#= HtmlHelper::viewField($content);?>
        <?=$content[0]['about_body']['field']['body'];?>
      </div>
    </div>
  </div>
</section>