public class AccountInlineEditvf {
    public List<Account> acclst = new List<Account>();
    
    
    public List<Account> getAccount(){
        acclst=[SELECT name,industry,type,Description FROM Account];
        return acclst;
    }
    public void save1()
    {
        update acclst;
    }

}