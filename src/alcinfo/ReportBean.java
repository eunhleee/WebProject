package alcinfo;

public class ReportBean {
	private int num;     
	private String  regroup;  
	private String  retitle;   
	private String  recontent;    
	private String  reid;    
	private String  stopid;		
	private String  reip;   
	private String  restate;    
	private String  olddate;	
	private String  newdate;
	private String email;
	private int grade; 
	private String mdate;
	private String kind;
	private int conum;
	private int depth;
	public int getConum() {
		return conum;
	}
	public void setConum(int conum) {
		this.conum = conum;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	private int	    Renum;
	private MemberBean bean = new MemberBean();
	private String name;
	
	
	@Override
	public String toString() {
		return "ReportBean [num=" + num + ", regroup=" + regroup + ", retitle=" + retitle + ", recontent=" + recontent
				+ ", reid=" + reid + ", stopid=" + stopid + ", reip=" + reip + ", restate=" + restate + ", olddate="
				+ olddate + ", newdate=" + newdate + ", Renum=" + Renum + ", bean=" + bean + ", name=" + name + "]";
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRenum() {
		return Renum;
	}
	public void setRenum(int renum) {
		Renum = renum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRegroup() {
		return regroup;
	}
	public void setRegroup(String regroup) {
		this.regroup = regroup;
	}
	public String getRetitle() {
		return retitle;
	}
	public void setRetitle(String retitle) {
		this.retitle = retitle;
	}
	public String getRecontent() {
		return recontent;
	}
	public void setRecontent(String recontent) {
		this.recontent = recontent;
	}
	public String getReid() {
		return reid;
	}
	public void setReid(String reid) {
		this.reid = reid;
	}
	public String getStopid() {
		return stopid;
	}
	public void setStopid(String stopid) {
		this.stopid = stopid;
	}
	public String getReip() {
		return reip;
	}
	public void setReip(String reip) {
		this.reip = reip;
	}
	public String getRestate() {
		return restate;
	}
	public void setRestate(String restate) {
		this.restate = restate;
	}
	public String getOlddate() {
		return olddate;
	}
	public void setOlddate(String olddate) {
		this.olddate = olddate;
	}
	public String getNewdate() {
		return newdate;
	}
	public void setNewdate(String newdate) {
		this.newdate = newdate;
	} 
	
	
}
