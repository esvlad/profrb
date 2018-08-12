<?
class ControllerFaqAdd extends MVC{
	public function question(){
		$json = array();

		$faq_model = new Action(MODEL, 'faq/crud');

		$result = $faq_model->loader('addQuestion', $_POST);

		if($result){
			$json['success'] = true;
			$json['question_id'] = $result['question_id'];
			$json['data'] = $result['data'];
		} else {
			$json['error'] = array('captcha'=>true);
		}

		echo json_encode($json);
	}

	public function question_file(){
		$json = array();

		//$json['file_question'] = $_FILES;

		$faq_model = new Action(MODEL, 'faq/crud');

		foreach($_FILES as $file){
			$json['file_question'][] = $faq_model->loader('addQuestionFile', $file);
		}

		echo json_encode($json);
	}

	public function comments(){
		$json = array();

		$faq_model = new Action(MODEL, 'faq/crud');

		$result = $faq_model->loader('addComments', $_POST);

		if($result){
			$json['success'] = true;
		} else {
			$json['error'] = array('captcha'=>true);
		}

		echo json_encode($json);
	}
}
?>