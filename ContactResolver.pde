import java.util.Iterator ;

class ContactResolver {
 
  // Resolves a set of particle contacts
  void resolveContacts(ArrayList<Contact> contacts) {
    //Iterator itr = contacts.iterator() ;
    //while(itr.hasNext()) {
     // Contact contact = (Contact)itr.next() ;
     for (Contact contact : contacts){
      contact.resolve() ;
     }
    //} 
  }
}