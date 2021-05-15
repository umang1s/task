import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'model/class.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({@required this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.width / 1.5,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 3),
                    borderRadius: BorderRadius.circular(size.width / 3),
                  ),
                  child: CircleAvatar(
                    radius: size.width / 5,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.person,
                      size: size.width / 3.2,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.user.firstName + " " + widget.user.lastName,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  child: Text(
                    '  Edit Profile  ',
                    style: TextStyle(
                        backgroundColor: Colors.white,
                        fontSize: 19,
                        color: Colors.red),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: size.width - 100,
            height: 70,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Location"),
              initialValue: widget.user.location,
              onChanged: (value) {
                widget.user.location = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width - 100,
            height: 70,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Pincode"),
              initialValue: widget.user.pincode.toString(),
              maxLength: 6,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.user.location = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width - 100,
            height: 70,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Date of Birth"),
              initialValue: "dd-mm-yy",
              //keyboardType: ,
              onChanged: (value) {
                widget.user.location = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width - 100,
            height: 70,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Gender"),
              initialValue: widget.user.gender,
              onChanged: (value) {
                //show all gender availble in overlay widget********************
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width - 100,
            height: 80,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "WhatsApp",
                prefix: GestureDetector(
                  onTap: () {
                    ///show all country code******************************* in Overlay widget
                  },
                  child: Text("+${widget.user.coutryCode}- "),
                ),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              initialValue: widget.user.whatsAppNo,
              onChanged: (value) {
                // widget.user.location = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width - 100,
            height: 70,
            child: TextFormField(
              decoration: InputDecoration(labelText: "email"),
              initialValue: widget.user.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //widget.user.email = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }


  _showCountryCodeOption(){

  }


  _showGenderOption(){

  }

  _showDateOption(){
    
  }
}
