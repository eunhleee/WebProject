package alcinfo;
import java.util.HashMap;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
public class Smssend {
	public static void send(String content, String phone) {
	    String api_key = "NCSDUIQXDZTEKGRK";
	    String api_secret = "YUOOKMEWW5KKTVNUBXGPBSHNGPRYLGP4";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);
	    params.put("from", "01092339249");
	    params.put("type", "SMS");
	    params.put("text", content);
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	  }
	
	  public static void main(String[] args) {
			send( "테스트중입니다 화이팅", "01099139249");
			System.out.println("전송되나~~~~");


	  }
}
