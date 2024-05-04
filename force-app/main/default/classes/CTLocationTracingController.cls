public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c 
                 FROM Location_Tracing__c 
                 WHERE Location__r.Id=: locationId 
                 ORDER BY Visit_Date__c DESC];
    }
    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<id> personIds){
        return [SELECT Id, Person__c, Location__c
                 FROM Location_Tracing__c 
                 WHERE Person__c IN: personIds 
                 AND Visit_Date__c = LAST_N_DAYS:10];
    }
    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<id> locationIds){
        return [SELECT Id, Person__c, Location__c
                  FROM Location_Tracing__c 
                  WHERE Location__c IN: locationIds 
                  AND Person__r.Health_Status__c ='Green'
                  AND Visit_Date__c = LAST_N_DAYS:10];
    }
}