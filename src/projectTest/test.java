package projectTest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class test {

	public static void main(String[] args) throws IOException, ParseException {
		// TODO Auto-generated method stub
		
		String result;
		String areaTop="부산광역시";	//지역
		String areaMdl="연제구";
		String areaLeaf="연산6동";
		String code="";	//지역 코드
		String x;
		String y;

		
		
		URL url;
		BufferedReader br;
		URLConnection conn;
		
		JSONParser parser;
		JSONArray jArr;
		JSONObject jobj;
		
        //시 검색
		url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/top.json.txt");
		conn = url.openConnection();
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		result = br.readLine().toString();
		br.close();
		//System.out.println(result);
		
		parser = new JSONParser(); 
        jArr = (JSONArray) parser.parse(result);
        for(int i = 0 ; i < jArr.size(); i++) {
        	jobj = (JSONObject) jArr.get(i);
        	if(jobj.get("value").equals(areaTop)) {
        		code=(String)jobj.get("code");
        		System.out.println(areaTop+"코드 : "+code);
        		break;
        	}
        }
        
        //구 검색
        url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/mdl."+code+".json.txt");
		conn = url.openConnection();
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		result = br.readLine().toString();
		br.close();
		//System.out.println(result);
		
		parser = new JSONParser(); 
        jArr = (JSONArray) parser.parse(result);
        
        for(int i = 0 ; i < jArr.size(); i++) {
        	jobj = (JSONObject) jArr.get(i);
        	if(jobj.get("value").equals(areaMdl)) {
        		code=(String)jobj.get("code");
        		System.out.println(areaMdl+"코드 : "+code);
        		break;
        	}
        }
        
        //동 검색
        url = new URL("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf."+code+".json.txt");
		conn = url.openConnection();
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		result = br.readLine().toString();
		br.close();
		//System.out.println(result);
		
		parser = new JSONParser(); 
        jArr = (JSONArray) parser.parse(result);
        
        if(areaMdl.equals("연제구")) {
        	for(int i = 0 ; i < jArr.size(); i++) {
            	jobj = (JSONObject) jArr.get(i);
            	
            	String leaf1=areaLeaf.substring(0,areaLeaf.length()-3);
        		String leaf2=areaLeaf.substring(areaLeaf.length()-3,areaLeaf.length()-2);
        		String leaf3=areaLeaf.substring(areaLeaf.length()-2,areaLeaf.length());
        		
        		Pattern pattern = Pattern.compile(leaf1+"[1-9.]{0,8}"+leaf2+"[1-9.]{0,8}"+leaf3);
        		Matcher matcher = pattern.matcher((String) jobj.get("value"));
            	if(matcher.find()) {
            		x=(String)jobj.get("x");
            		y=(String)jobj.get("y");
            		System.out.println(areaLeaf+"의 x값 : "+x+", y값 :"+y);
            		break;
            	}
            }
        }else {
        	for(int i = 0 ; i < jArr.size(); i++) {
            	jobj = (JSONObject) jArr.get(i);
            	if(jobj.get("value").equals(areaLeaf)) {
            		x=(String)jobj.get("x");
            		y=(String)jobj.get("y");
            		System.out.println(areaLeaf+"의 x값 : "+x+", y값 :"+y);
            		break;
            	}
            }
        }
        
        
	}
}