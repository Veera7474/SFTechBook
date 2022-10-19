trigger UpdateName on Address__c (before insert) {
for(Address__c acc : Trigger.new)
{
    Acc.Name = 'Don';
}
}