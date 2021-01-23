
import 'package:reale/newCode/Dropdowns/DescDropDowns4.dart';
import 'package:reale/newCode/Dropdowns/DropDown_1.dart';
import 'package:reale/newCode/Dropdowns/DropDown_2.dart';
import 'package:reale/newCode/Dropdowns/DropDown_3.dart';
import 'package:reale/newCode/Dropdowns/DropDown_4.dart';
import 'package:reale/newCode/Dropdowns/DropDown_5.dart';
import 'package:reale/newCode/Dropdowns/DropDown_6.dart';
import 'package:reale/newCode/Dropdowns/DropDown_7.dart';
import 'package:reale/newCode/Dropdowns/DescDropDowns1.dart';
import 'package:reale/newCode/Dropdowns/DescDropDowns2.dart';
import 'package:reale/newCode/Dropdowns/DescDropDowns3.dart';
import 'package:reale/newCode/data.dart';



class MainDropDown{

  MainDropDown({this.d1,
    this.d2,
    this.  d3,
    this.  d4,
    this.  d5,
    this.  d6,
    this.  d7,
    this.  ds1,
    this.  ds2_Residential_dependent,
    this.  ds3,
    this.  ds4});

  init(){
    if(d1  ==null)
    d1  = DropDown_1();

    if(d2 ==null)
    d2 =DropDown_2();

    if(d3 ==null)
    d3 =DropDown_3();

    if(d4 ==null)
    d4 =DropDown_4();

    if(d5 ==null)
    d5 =DropDown_5();

    if(d6 ==null)
    d6 =DropDown_6();

    if(d7 ==null)
    d7 =DropDown_7();


    if(ds1 ==null)
      ds1 =DescDropDown1();


    if(ds2_Residential_dependent ==null)
      ds2_Residential_dependent =DescDropDown2(residentialType);


    if(ds3 ==null)
      ds3 =DescDropDown3();

    if(ds4 ==null)
      ds4 =DescDropDown4();




  }
  DropDown_1 d1  = DropDown_1();
  DropDown_2 d2 =DropDown_2() ;
  DropDown_3 d3 =DropDown_3() ;
  DropDown_4 d4 =DropDown_4() ;
  DropDown_5 d5 =DropDown_5() ;
  DropDown_6 d6 =DropDown_6() ;
  DropDown_7 d7 =DropDown_7() ;

  DescDropDown1 ds1  = DescDropDown1();

  DescDropDown2 ds2_Residential_dependent  = DescDropDown2(residentialType);
  DescDropDown2 ds2_Commercial_dependent  = DescDropDown2(commercialType);
  DescDropDown2 ds2_Land_dependent  = DescDropDown2(LandType);


  DescDropDown3 ds3  = DescDropDown3();
  DescDropDown4 ds4  = DescDropDown4();

  @override
  String toString(){
print(d1.id);
return
    d1.hint + ' --  '+ d1.id +'  = ' +d1.name+'\n'+
    d2.hint + ' --  '+ d2.id +'  = ' +d2.name+'\n'+
    d3.hint + ' --  '+ d3.id +'  = ' +d3.name+'\n'+
    d4.hint + ' --  '+ d4.id +'  = ' +d4.name+'\n'+
    d5.hint + ' --  '+ d5.id +'  = ' +d5.name+'\n'+
    d6.hint + ' --  '+ d6.id +'  = ' +d6.name+'\n'+
    d7.hint + ' --  '+ d7.id +'  = ' +d7.name+'\n'+
    ds1.hint + ' --  '+ ds1.id +'  = ' +ds1.name+'\n'+
    ds2_Residential_dependent.hint + ' --  '+ ds2_Residential_dependent.id +'  = ' +ds2_Residential_dependent.name+'\n'+
    ds3.hint + ' --  '+ ds3.id +'  = ' +ds3.name+'\n'+
    ds4.hint + ' --  '+ ds4.id +'  = ' +ds4.name+'\n';

  }

  bool isFilled(){


    if(d1.name=='0'){
      return false;
    }
    if(d2.name=='0'){
      return false;
    }
    // if(d3.name=='0'){
    //   return false;
    // }
    if(d4.name=='0'){
      return false;
    }
    if(d5.name=='0'){
      return false;
    }

    if(d6.name=='0'){
      return false;
    }
    if(d7.name=='0'){
      return false;
    }
    // if(ds1.name=='0'){
    //   return false;
    // }
    // if(ds2.name=='0'){
    //   return false;
    // }
    // if(ds3.name=='0'){
    //   return false;
    // }
    if(ds4.name=='0'){
      return false;
    }
return true;
  }

}