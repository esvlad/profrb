<?
class ClassMail
{
	private $to;
	public $from;
	public $subject;
	public $message;
	private $header;
	public $output;

	public function setTo($mail){
		$this->to = iconv('utf-8','windows-1251', $mail);
	}

	public function setFrom($from){
		$this->from = iconv('utf-8','windows-1251', $from);
	}

	public function setSubject($subject){
		$this->subject = iconv('utf-8','windows-1251', $subject);;
	}

	public function setMessage($message){
		$this->message = iconv('utf-8','windows-1251', $message);;
	}

	public function sendMail(){
		$this->headers = "Content-type: text/html; charset=windows-1251 \r\n";
		$this->headers .= "From: $this->from\r\n"; 
		$mail = mail($this->to, $this->subject, $this->message, $this->headers);

		if($mail === true){
			return true;
		} else {
			return false;
		}
	}
}
?>