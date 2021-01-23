


  class Search_controller{

  SearchDropdown d1 = SearchDropdown();
  SearchDropdown d2 = SearchDropdown();
  SearchDropdown d3 = SearchDropdown();
  SearchDropdown d4 = SearchDropdown();

resetall(){}
changeStatus(bool isChecked, String label, int index){
  print(index);
  if(index ==0){
    d1 .search= isChecked;
  }
  else   if(index ==1){
    d2 .search= isChecked;
  }
  else   if(index ==2){    d2 .search= isChecked;
  }
  else   if(index ==3){    d3 .search= isChecked;
  }
  else   if(index ==4){    d4 .search= isChecked;
  }
  else   if(index ==5){
    // d5 .search= isChecked;

  }


}


}

class SearchDropdown{

  String label='';
  String id;
  List<String> lst;
  List<String> idlst;

  bool search = false;
  setid(newlabel){
    label = newlabel;
    id  = idlst[lst.indexOf(newlabel)];

  }


}