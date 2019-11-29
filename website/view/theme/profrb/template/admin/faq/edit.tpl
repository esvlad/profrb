<h2 class="modal_title">Редактирование вопроса</h2>

<form class="admin_form clearfix" method="post" data-table="faq" data-params="update">
    <input type="hidden" name="content_id" value="<?=$content_id;?>">
    <div class="admin_form_row">
      <label for="category">Категория</label>
      <p class="admin_form_caption">Выберите категорию</p>
      <select id="category" name="category_id" data-table="faq">
        <? foreach($category as $cat) : ?>
          <? if($cat['id'] == $category_id) : ?>
            <option value="<?=$cat['id'];?>" selected><?=$cat['title'];?></option>
          <? else : ?>
            <option value="<?=$cat['id'];?>"><?=$cat['title'];?></option>
          <? endif; ?>
        <? endforeach; ?>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="question_author_bilet">Номер профсоюзного билета</label>
      <input id="question_author_bilet" type="text" name="question_author_bilet" data-table="faq" value="<?=$question_author_bilet;?>" disabled/>
    </div>
    <div class="admin_form_row">
      <label for="question">Вопрос</label>
      <p class="admin_form_caption">Текст вопроса, <b>обязательно для заполнения</b></p>
      <textarea id="question" name="question" data-table="faq" required><?=$question;?></textarea>
    </div>
    <div class="admin_form_row">
      <label for="question_author_name">Автор</label>
      <p class="admin_form_caption">Введите имя автора вопроса, <b>обязательно для заполнения</b></p>
      <input id="question_author_name" type="text" name="question_author_name" data-table="faq" value="<?=$question_author_name;?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="question_author_from">От куда?</label>
      <p class="admin_form_caption">Город или населенный пункт, <b>обязательно для заполнения</b></p>
      <input id="question_author_from" type="text" name="question_author_from" data-table="faq" value="<?=$question_author_from;?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="question_author_work">Место работы</label>
      <p class="admin_form_caption">Место работы автора вопроса, <b>обязательно для заполнения</b></p>
      <input id="question_author_work" type="text" name="question_author_work" data-table="faq" value="<?=$question_author_work;?>" required/>
    </div>
    <div class="admin_form_row">
      <label for="question_author_mail">E-mail</label>
      <p class="admin_form_caption">E-mail автора вопроса</p>
      <input id="question_author_mail" type="text" name="question_author_mail" data-table="faq" value="<?=$question_author_mail;?>"/>
    </div>
    <? if(count((array)$question_docs) >= 1) : ?>
      <div class="admin_form_row">
        <label>Прикрепленные документы</label>
        <? foreach($question_docs as $docs) : ?>
          <p class="admin_form_caption"><a href="<?=$docs['path'];?>" target="_blank"><?=$docs['title'];?></a></p>
        <? endforeach; ?>
      </div>
    <? endif; ?>
    <div class="admin_form_row">
      <label for="answer">Ответ</label>
      <p class="admin_form_caption">Введите текст ответа</p>
      <textarea id="answer" name="answer" data-table="faq"><?=$answer;?></textarea>
    </div>
    <div class="admin_form_row">
      <label for="question_author_mail">Автор ответа</label>
      <p class="admin_form_caption">Выберите автора ответа или добавьте нового, <b>внимание, если выбираете добавить нового то действие отменить нельзя!</b></p>
      <select id="answer_author_id" name="answer_author_id" data-table="faq">
        <? foreach($answer_author as $author) : ?>
          <? if(isset($author_id) && $author['id'] == $author_id) : ?>
            <option value="<?=$author['id'];?>" seleced><?=$author['name'];?></option>
          <? else : ?>
            <option value="<?=$author['id'];?>"><?=$author['name'];?></option>
          <? endif; ?>
        <? endforeach; ?>
          <option value="new">Добавить нового</option>
      </select>
    </div>
    <div class="admin_form_row">
      <label for="date_creat">Дата публикации</label>
      <p class="admin_form_caption">Не обязательное поле, используется для сортировки вопросов <?=$date_creat;?></p>
      <input id="date_creat" type="date" name="date_creat" data-table="faq" value="<?=$date_creat;?>"/>
    </div>
    <div class="admin_form_row">
      <? if($no_comment == 1) : ?>
        <input id="no_comment" type="checkbox" name="no_comment" data-table="faq" value="" checked/>
      <? else : ?>
        <input id="no_comment" type="checkbox" name="no_comment" data-table="faq" value=""/>
      <? endif; ?>
      <label for="no_comment">Комментарии запрещены</label>
      <p class="admin_form_caption">Поставьте галочку если нужно запретить комментирование</p>
    </div>
    <div class="admin_form_row">
      <? if($active == 1) : ?>
        <input id="active" type="checkbox" name="active" data-table="faq" value="" checked/>
      <? else : ?>
        <input id="active" type="checkbox" name="active" data-table="faq" value=""/>
      <? endif; ?>
      <label for="active">Материал опубликован</label>
      <p class="admin_form_caption">Уберрите галочку если вопрос не должен отображаться на сайте</p>
    </div>
    <div class="admin_form_row">
      <? if($answered == 1) : ?>
        <input id="answered" type="checkbox" name="answered" data-table="faq" value="" checked/>
      <? else : ?>
        <input id="answered" type="checkbox" name="answered" data-table="faq" value=""/>
      <? endif; ?>
      <label for="answered">Вопрос просмотрен</label>
      <p class="admin_form_caption">Уберрите галочку если вопрос должен быть отмечен не просмотренным</p>
    </div>
    <div class="admin_form_row">
      <? if($question_author_to_mail == 1) : ?>
        <input id="question_author_to_mail" type="checkbox" name="question_author_to_mail" data-table="faq" value="" disabled checked/>
      <? else : ?>
        <input id="question_author_to_mail" type="checkbox" name="question_author_to_mail" data-table="faq" value="" disabled/>
      <? endif; ?>
      <label for="question_author_to_mail">Автор получит ответ по почте</label>
      <p class="admin_form_caption">Изменить нельзя</p>
    </div>
    <div class="admin_form_row">
      <? if($question_author_private == 1) : ?>
        <input id="question_author_private" type="checkbox" name="question_author_private" data-table="faq" value="" checked/>
      <? else : ?>
        <input id="question_author_private" type="checkbox" name="question_author_private" data-table="faq" value=""/>
      <? endif; ?>
      <label for="question_author_private">Автор решил скрыть свои данные на сайте</label>
    </div>
    <div class="admin_form_row" data-answered="<?=$answered;?>" data-question-mail="<?=$question_author_to_mail;?>">
      <? if($answered == 1 || $question_author_to_mail == 0) : ?>
        <input id="to_mail" type="checkbox" name="to_mail" value=""/>
      <? else : ?>
        <input id="to_mail" type="checkbox" name="to_mail" value="" checked/>
      <? endif; ?>
      <label for="to_mail">Отправить ответ на почту задавшему вопрос</label>
      <p class="admin_form_caption">Снимите галочку, если отправлять не нужно (например если ответ дан, но нужно внести редакцию)</p>
    </div>
    <div class="admin_form_row btns">
      <button class="btn brd btn_admin" id="save" data-btn-event="save">Сохранить</button>
    </div>
</form>

<script>

CKEDITOR.replace('question');
CKEDITOR.replace('answer');

var form_file;
$('div#fileUploaded').click(function(){
  form_file = $(this).parent().children('.file_upload_input');
  form_file.trigger('click');
});

var author_id;
$('#answer_author_id').change(function(){
  author_id = $(this).val();

  if(author_id == 'new'){
    parent_element = $(this).parent();
    $(this).detach();
    parent_element.append('<input id="answer_author_id" type="hidden" name="answer_author_id" data-table="faq" value="0"/><p class="admin_form_caption">Введите имя автора ответа</p><input type="text" name="name" value="" data-table="faq_answer" required><br><p class="admin_form_caption">Введите должность автора ответа</p><input type="text" id="author_caption" name="caption" data-table="faq_answer required"/>');
  }
});

var form_error;
$('.admin_modal #save').click(function(e){
  e = e || event;
  e.preventDefault();

  form_error = false;

  var my_form = $(this).parents('.admin_form');

  if(my_form.find('input[required], textarea[required]')){
    my_form.find('input[required], textarea[required]').removeClass('error_form');
    mi = 0;
    my_form.find('input[required], textarea[required]').each(function(){
      my_text = $(this).val();
      if(my_text == '' || my_text == undefined){
        $(this).addClass('error_form');
        form_error = true;
      }
    });
  }

  if(!form_error){
    var post_data = {};

    my_form.find('input, select, textarea').each(function(){
      if($(this).attr('id') == 'question'){
        post_data[$(this).attr('name')] = CKEDITOR.instances['question'].getData();
      } else if($(this).attr('id') == 'answer'){
        post_data[$(this).attr('name')] = CKEDITOR.instances['answer'].getData();
      } else {
        if($(this).attr('type') == 'checkbox'){
          if($(this).is(':checked')){
            post_data[$(this).attr('name')] = 1;
          } else {
            post_data[$(this).attr('name')] = 0;
          }
        } else {
          post_data[$(this).attr('name')] = $(this).val();
        }
      }
    });

    $.ajax({
      url: 'index.php?r=admin/faq/update',
      type: 'post',
      data: post_data,
      dataType: 'json',
      success: function(json){
        console.log(json);
        if(json.success == true){
          //console.log('Спасибо всё отлично!');
          
          if(json.redirect){
            location = json.redirect;
          }

        } else {
          console.log('Что-то пошло не так!');
        }
      },
      error: function(xhr, ajaxOptions, thrownError){
        console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }

  //console.log(post_data);
});
</script>