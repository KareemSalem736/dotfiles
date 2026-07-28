/**  
 * The combination key type for the access cache table */public record AccessCacheKey(String userDn, JSONB acm) {  
    public static AccessCacheKey of(UserDn userDn, Acm acm) {  
       return new AccessCacheKey(userDn.dn(), jsonb(jsonHelper().toJson(acm)));  
    }  
}