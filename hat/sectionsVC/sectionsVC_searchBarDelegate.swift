import UIKit
extension sectionsVC {
//####################      SEARCH BAR DELEGATE BLOCK      ############################################
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            updateSections()
            //print(searchBar.tag)

        }
       
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           //if withCancelButton
           searchBar.setShowsCancelButton(true, animated: true)
           
           //if withOUT CancelButton:
           //searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            resetSearchBar(searchBar)
            updateSections()

        }
    
        // reset searchbar
        func resetSearchBar(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
//#########################################################################################


}