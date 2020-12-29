<h2 class="modal_title">Показаны все выплаты</h2>
<div class="admin_content_view calc_compensation_or_pays">
  <div id="calc_add_positions" class="btn brd btn_admin btn_calc_add">Добавить выплату</div>
  <div class="admin_filter calc_position_filter">
    Фильтр по должности: <select name="position_id" onchange="calc_cp_filter(this.value, 'p');">
      <? if(!$position_id) : ?>
        <option value="0" selected>Все должности</option>
      <? else : ?>
        <option value="0">Все должности</option>
      <? endif; ?>
      <? foreach($positions as $position) : ?>
        <? if($position_id == $position['id']) : ?>
          <option value="<?=$position['id'];?>" selected><?=$position['name'];?></option>
        <? else : ?>
          <option value="<?=$position['id'];?>"><?=$position['name'];?></option>
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
          <p id="oklad">Название выплаты</p>
        </td>
        <td>
          <p id="oklad">Размер выплаты</p>
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
            <p class="content_views_title"><?=mb_substr($content['name'], 0, 110);?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['value']?></p>
          </td>
          <td>
            <p class="content_views_title"><?=$content['position']?></p>
          </td>
          <td>
            <? if($content['active'] == 1) : ?>
              <span data-content-id="<?=$content['id']?>" onclick="status_calc_comp_or_pays(<?=$content['id']?>, 'p')" class="content_event admin_calc_active admin_icon icon_active">Включено</span>
              <input id="status_calc_comp_or_pays<?=$content['id']?>" type="hidden" name="active" value="1">
            <? else : ?>
              <span data-content-id="<?=$content['id']?>" onclick="status_calc_comp_or_pays(<?=$content['id']?>, 'p')" class="content_event admin_calc_active admin_icon icon_active">Выключено</span>
              <input id="status_calc_comp_or_pays<?=$content['id']?>" type="hidden" name="active" value="0">
            <? endif; ?>
          </td>
          <td>
            <span onclick="calc_comp_or_pays_edit(<?=$content['id']?>, 'p');" class="content_event admin_icon icon_update">Редактировать</span>
          </td>
          <td>
            <span id="deleted" onclick="calc_comp_or_pays_delete(<?=$content['id']?>, 'p')" data-content-id="<?=$content['id']?>" class="content_event admin_icon icon_delete">Удалить</span>
          </td>
        </tr>
      <? endforeach; ?>
    </tbody>
  </table>
</div>
<script>
  $('#calc_add_positions').click(function(){
    $('.admin_section a[href="admin/calculator/addPays"]').trigger('click');
  });
</script>