import com.jsd.service.JsdCustomer;
import com.newrmgps.mybatis.sdk.factory.NewRmgpsFacotry;


public class testdb {
	public static void main(String[] args){
		JsdCustomer jsdc=NewRmgpsFacotry.getJsdCustomer();
		int checkCustomerName = jsdc.checkCustomerName(40, "三级测试客户");
		System.out.println(checkCustomerName);
	}
}
