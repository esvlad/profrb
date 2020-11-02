<h2 class="modal_title">Показаны все места работы</h2>
<div id="calc_add_jobs" class="btn brd btn_admin btn_calc_add">Добавить место работы</div>
<div class="admin_content_view calc_jobs">
  <table class="admin_content_table">
  <thead data-types="">
    <tr>
      <td>
        <p>ID</p>
      </td>
      <td>
        <p id="name">Название места работы</p>
      </td>
      <td>
        <p id="position">Порядок</p>
      </td>
      <td>
        <p id="status">Состояние</p>
      </td>
      <td></td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <? foreach($contents as $content) : ?>
      <tr class="admin_content_row" data-content-type-id="0" data-content-id="<?=$content['id']?>">
        <td>
          <p><?=$content['id']?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$content['name']?></p>
        </td>
        <td>
          <p class="content_views_title"><?=$content['position']?></p>
        </td>
        <td>
          <? if($content['active'] == 1) : ?>
            <span data-content-id="<?=$content['id']?>" onclick="status_calc_jobs(<?=$content['id']?>)" class="content_event admin_calc_active admin_icon icon_active">Включено</span>
            <input id="status_calc_jobs<?=$content['id']?>" type="hidden" name="active" value="1">
          <? else : ?>
            <span data-content-id="<?=$content['id']?>" onclick="status_calc_jobs(<?=$content['id']?>)" class="content_event admin_calc_active admin_icon icon_active">Выключено</span>
            <input id="status_calc_jobs<?=$content['id']?>" type="hidden" name="active" value="0">
          <? endif; ?>
        </td>
        <td>
          <span onclick="calc_jobs_edit(<?=$content['id']?>);" class="content_event admin_icon icon_update">Редактировать</span>
        </td>
        <td>
          <span id="deleted" onclick="calc_jobs_delete(<?=$content['id']?>)" data-content-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
        </td>
      </tr>
    <? endforeach; ?>
  </tbody>
  </table>
</div>
<script>
  $('#calc_add_jobs').click(function(){
    $('.admin_section a[href="admin/calculator/addJobs"]').trigger('click');
  });
</script>