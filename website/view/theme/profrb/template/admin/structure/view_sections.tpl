<h2 class="modal_title">Секции</h2>
<ul>
  <? if(!empty($sections)) : ?>
    <? foreach($sections as $section) : ?>
      <li>
        <a href="admin/structure/section" data-post-type="section" data-post-events="update" data-post-params="<?=$section['id'];?>" data-admin-role="99"><?=$section['title'];?></a>
      </li>
    <? endforeach; ?>
  <? endif; ?>
</ul>