public with sharing class CTPersonController {
    public static String getToken(String mobileNo){
        Blob value= Blob.valueOf(mobileNo);
        Blob hash= Crypto.generateDigest('MD5',value);

        return EncodingUtil.base64Encode(hash);
    }
    public static List<Person__c> getRecentHealthChanges(){
       List<Person__c> personsRecords= [SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c 
                                         FROM Person__c 
                                         ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];

       return personsRecords;
    }
    public static List<Person__c> searchPeople(String searchTerm){
        List<Person__c> searchResult= [SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c 
                                        FROM Person__c 
                                        WHERE Name LIKE: 'searchTerm%' OR Mobile__c LIKE: 'searchTerm%'  OR Token__c LIKE: 'searchTerm%' ORDER BY Status_Update_Date__c DESC];
        return searchResult;
    }
    public static Person__c getPersonById(String personId){
        List<Person__c> personRecord=[SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c 
                                        FROM Person__c 
                                        WHERE Id =: personId];
        if(personRecord != null && personRecord.size()>0){
            return personRecord[0];
        }
        return null;
    }
}
