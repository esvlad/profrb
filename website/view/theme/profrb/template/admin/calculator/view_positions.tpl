<h2 class="modal_title">Показаны все места работы</h2>
<div class="admin_content_view calc_positions">
  <div class="admin_filter faq_category">
    Фильтр по месту работы: <select name="job_id" onchange="calc_job_filter(this.value);">
      <? if(!$job_id) : ?>
        <option value="0" selected>Все места работы</option>
      <? else : ?>
        <option value="0">Все места работы</option>
      <? endif; ?>
      <? foreach($jobs as $job) : ?>
        <? if($job_id == $job['id']) : ?>
          <option value="<?=$job['id'];?>" selected><?=$job['name'];?></option>
        <? else : ?>
          <option value="<?=$job['id'];?>"><?=$job['name'];?></option>
        <? endif; ?>
      <? endforeach; ?>
    </select>
  </div>
  <table class="admin_content_table">
    <thead data-types="">
      <tr>
        <td>
          <p>ID</p>
        </td>
        <td>
          <p id="job">Место работы</p>
        </td>
        <td>
          <p id="name">Должность</p>
        </td>
        <td>
          <p id="oklad">Оклад</p>
        </td>
        <td>
          <p id="norm_hour">Норма часов</p>
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
            <p class="content_views_title"><?=$content['job_name']?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['name']?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['oklad']?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['norm_hour']?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['position']?></p>
          </td>
          <td>
            <? if($content['active'] == 1) : ?>
              <span data-content-id="<?=$content['id']?>" onclick="status_calc_position(<?=$content['id']?>)" class="content_event admin_calc_active admin_icon icon_active">Включено</span>
              <input id="status_calc_position<?=$content['id']?>" type="hidden" name="active" value="1">
            <? else : ?>
              <span data-content-id="<?=$content['id']?>" onclick="status_calc_position(<?=$content['id']?>)" class="content_event admin_calc_active admin_icon icon_active">Выключено</span>
              <input id="status_calc_position<?=$content['id']?>" type="hidden" name="active" value="0">
            <? endif; ?>
          </td>
          <td>
            <span onclick="calc_position_edit(<?=$content['id']?>);" class="content_event admin_icon icon_update">Редактировать</span>
          </td>
          <td>
            <span id="deleted" onclick="calc_position_delete(<?=$content['id']?>)" data-content-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
          </td>
        </tr>
      <? endforeach; ?>
    </tbody>
  </table>
</div>
