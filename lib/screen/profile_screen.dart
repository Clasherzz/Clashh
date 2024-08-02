
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/apis/apis.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screen/auth/login_screen.dart';
import 'package:flutter_application_2/screen/helpers/dialogs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  
  const ProfileScreen( {super.key, required this.user });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
   String? _image;
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: FocusScope.of(context).unfocus,//to turn off keyboard by tuching anywhere on screen
    child:Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Profile"),
        ),
        
      body:Form(//the form is here for validation and updationn really good one
        key:_formKey,
        child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 10) ,
        child: Column(
        children: [
          Stack(
            children:[

              _image == null ?

           ClipRRect(
          borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height * 0.1),
         child: CachedNetworkImage(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          imageUrl: "https://www.google.com/search?q=pictures&sca_esv=a835f771045fe61e&sca_upv=1&rlz=1C1VDKB_enIN1022IN1022&sxsrf=ADLYWIKPN2556JvP6OKj48qkkKLRUl9D7A:1721219669183&udm=2&source=iu&ictx=1&vet=1&fir=tYmxDgFq4MrkJM%252C-t22bY2ix3gHaM%252C%252Fm%252F0jg24%253BsKMM4eBjWSQEBM%252CB51x0PBR9KNzvM%252C_%253BL78jAzIbPtQBcM%252CbnFH7L5A1JFCTM%252C_%253BScnmyk9jYFSBNM%252CE-_aOwFp15AeLM%252C_%253BuJ0dNAI72KR-NM%252CIaGVCB8zjywltM%252C_%253BlfWnW2IEnhbPvM%252CePjCKhFm09p5bM%252C_%253Bc_k0XZB-zd8bBM%252CqMZ3UDNPbU6AlM%252C_&usg=AI4_-kTs2JcVvVzzCwrvJa83_cAtp_Z2Pg&sa=X&ved=2ahUKEwj30tj3iq6HAxVtyjgGHT9VAE4Q_B16BAgmEAE#vhid=tYmxDgFq4MrkJM&vssid=mosaic",
          placeholder: (context,url)=>  const CircularProgressIndicator(),
          errorWidget: (context,url,error)=>const Icon(Icons.error),
          ),
          ) :

          ClipRRect(
          borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height * 0.1),
         child: Image.file(File(_image!)),
          )
          
          
          ,
          Positioned(
            bottom:0,
            right:0,
            child:IconButton(icon:Icon(Icons.edit),onPressed: (){_showBottomSheet();},) ,
            
            )
          
          ],),
          Text(widget.user.email),
          TextFormField(
            initialValue: widget.user.name,
            onSaved: (value) => APIs.me.name = value ?? "",
           // onChanged: (value) => APIs.me.name = value ?? "",
            validator: (value) => value != null && value.isNotEmpty ? null : 'Required Field' ,
            decoration: InputDecoration(prefixIcon:Icon(Icons.person,),label:Text("Name")),
          ),
          TextFormField(
            initialValue: widget.user.about,
            onSaved: (value) => APIs.me.about = value ?? "",
             //onChanged: (value) => APIs.me.name = value ?? "",
            validator: (value) => value != null && value.isNotEmpty ? null : 'Required Field' ,
            decoration: InputDecoration(prefixIcon:Icon(Icons.info,),label:Text("About")),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.edit),
            label: Text("EDIT"),
            
            
            onPressed: () async{
              if(_formKey.currentState!.validate()){

                _formKey.currentState!.save();

                print("about${APIs.me.about}");
              await APIs.updateUserInfo();
              }
              
            })

        ]
      ),),),
      floatingActionButton: Padding(padding: EdgeInsets.only(bottom: 0.05),
        child:FloatingActionButton.extended(
          backgroundColor: Colors.grey,
          onPressed: ()async{
            Dialogs.progressBar(context);
            await APIs.auth.signOut().then((value) async{
              await GoogleSignIn().signOut().then((value){
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=> LoginScreen()));
              }

              );
            },);

          }, label: Text("Logout"),icon:Icon(Icons.logout))
      ),
      
     
       
    ));

  }

  void _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
       
      ),
       builder: (_){
         
            return ListView(
              shrinkWrap: true,
              padding:EdgeInsets.only(left:10,bottom:10),
              children: [
                
                Text("Pick your image"),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                IconButton(onPressed: ()async{
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = 
                    await picker.pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      setState(() {
                        _image = image.path;

                      });
                      APIs.updateProfile(image as File);
                      Navigator.pop(context);
                    }
                  
                },
                
                 
                 icon: Icon(Icons.image),),
                IconButton(onPressed: ()async{
                   final ImagePicker picker = ImagePicker();
                  final XFile? image = 
                    await picker.pickImage(source: ImageSource.camera);
                    if(image!=null){
                      setState(() {
                        _image = image.path;

                      });
                      APIs.updateProfile(image as File);
                      Navigator.pop(context);
                    }

                }, icon: Icon(Icons.camera))
                ]
                )
              ],

            );

          
        }


    );
  }
}

