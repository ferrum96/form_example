import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_example/model/user.dart';
import 'package:form_example/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Russia', 'Ukraine', 'Germany', 'France', 'USA'];
  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _passConfFocus = FocusNode();

  User user = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "FullName *",
                hintText: "What do people call you?",
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black)),
              ),
              validator: _validateName,
              onSaved: (value) => user.name = value,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                focusNode: _phoneFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _phoneFocus, _emailFocus);
                },
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number *",
                  hintText: "Where can we reach you?",
                  helperText: 'Phone format +X(XXX)XXX-XX-XX',
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _phoneController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black)),
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
                onSaved: (value) => user.phone = value),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _emailFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _emailFocus, _passFocus);
              },
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email Address",
                hintText: "Enter a email address?",
                icon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              onSaved: (value) => user.email = value!,
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              items: _countries.map((country) {
                return DropdownMenuItem(child: Text(country), value: country);
              }).toList(),
              onChanged: (data) {
                print(data);
                setState(() {
                  _selectedCountry = data as String?;
                  user.country = _selectedCountry!;
                });
              },
              value: _selectedCountry,
              //validator: (value) {
              //  return value == null ? 'Please select a country' : null;
              //},
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: "Life Story",
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short, this is just a demo',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 100,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              onSaved: (value) => user.story = value!,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _passFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _passFocus, _passConfFocus);
              },
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 16,
              decoration: InputDecoration(
                labelText: "Password *",
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.vpn_key_outlined),
              ),
              validator: _validatePass,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _passConfFocus,
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 16,
              decoration: InputDecoration(
                labelText: "Confirm Password *",
                icon: Icon(Icons.border_color),
              ),
              validator: _validateConfirmPass,
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: _submitForm,
              color: Colors.blue,
              child: Text(
                'Submit Form',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Country: $_selectedCountry');
      print('Story: ${_storyController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please try again.');
    }
  }

  String? _validateName(String? input) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (input!.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(input)) {
      return 'Please enter correct characters';
    } else {
      return null;
    }
  }

  String? _validatePhone(String? input) {
    final _phoneExp = RegExp(r'^\+\d{1,2}\(\d{3}\)\d{3}-\d{2}-\d{2}$');
    if (!_phoneExp.hasMatch(input!)) {
      return 'Phone number must be entered as +X(XXX)XXX-XX-XX';
    } else {
      return null;
    }
  }

  String? _validateEmail(String? input) {
    final _emailExp = RegExp(
        r'(^$|^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(?:[a-zA-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$)');
    if (!_emailExp.hasMatch(input!)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePass(String? input) {
    final _passExp =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^\w\s]).{8,}');
    if (!_passExp.hasMatch(input!)) {
      return 'Invalid password! \nPassword must contain at least eight characters, \nat least one number and both lower and \nuppercase letters and special characters.';
    } else {
      return null;
    }
  }

  String? _validateConfirmPass(String? value) {
    if (!(value == _passController.text)) {
      return 'Password mismatch';
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Registration successful',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(
            '$name is now verifed register form',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Route route = MaterialPageRoute(
                    builder: (context) => UserInfoPage(userInfo: user));
                Navigator.push(context, route);
              },
              child: Text(
                'Verified',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
