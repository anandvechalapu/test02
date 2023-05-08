public with sharing class StudentPhoneNumberUpdate {

    // This trigger will fire whenever a new Student__c record is created
    trigger UpdateStudentPhoneNumber on Student__c (after insert) {

        // Create a list of ids to store the Student__c records that were inserted
        List<Id> studentIds = new List<Id>();

        // Loop through the list of new Student__c records
        for(Student__c s : Trigger.new) {
            // Add the Id of the new record to the list
            studentIds.add(s.Id);
        }

        // Get the phone numbers from the Student__c records
        List<Student__c> students = [SELECT Id, Phone__c FROM Student__c WHERE Id IN :studentIds];

        // Create a list of updates to store the updates for the Mobile__c field
        List<Student__c> updates = new List<Student__c>();

        // Loop through the Student__c records
        for(Student__c s : students) {
            // Create a new Student__c record and populate the fields
            Student__c studentUpdate = new Student__c();
            studentUpdate.Id = s.Id;
            studentUpdate.Mobile__c = s.Phone__c;

            // If the Phone__c field is blank, set the Mobile__c field to null
            if(s.Phone__c == null) {
                studentUpdate.Mobile__c = null;
            }

            // Add the update to the list of updates
            updates.add(studentUpdate);
        }

        // Update the Mobile__c field with the phone number of the Student__c record
        if(updates.size() > 0) {
            update updates;
        }
    }
}