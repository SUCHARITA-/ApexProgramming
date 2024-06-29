trigger OnContactInsert on Contact (after insert) {
    ThinkingInApex.afterInsertContact(trigger.new);
}