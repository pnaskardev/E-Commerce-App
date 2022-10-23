import 'dart:convert';
import 'package:ecommerce/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier
{
  String _token='';
  DateTime _expiryDate=DateTime.now();
  String _userId='';
 
 
 
 String get userId
 {
    return _userId;
 }


  bool get isAuth
  {
    if(_token=='')
    {
      return false;
    }
    return true;
  }


  String get token
  {
    if(_expiryDate!=null && _expiryDate.isAfter(DateTime.now()) && _token != null)
    {
      return _token ;
    }
    return '';
  }


  Future<void> signUp(String email,String password) async
  {
    const url='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBmWSuWoEdRhqD5k12tucFSl633glhtLEQ';
    try
      {
        final response = await http.post
        (
          Uri.parse(url),
          body: json.encode
          (
            {
              'email':email,
              'password':password,
              'returnSecureToken':true
            }
          )
        );
        // print(json.decode(response.body));
        final responseData=json.decode(response.body);
        if(responseData['error']!=null)
        {
          throw HttpException(message: responseData['error']['message']);
        }
        _userId=responseData['localId'];
        _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
        _token=responseData['idToken'];
        notifyListeners();
      }
      catch(error)
      {
        throw error;
      }
  }


  Future<void>signIn(String email,String password) async
  {
    const url='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBmWSuWoEdRhqD5k12tucFSl633glhtLEQ';
    try
    {
      final response = await http.post
      (
        Uri.parse(url),
        body: json.encode
        (
          {
            'email':email,
            'password':password,
            'returnSecureToken':true
          }
        )
      );
      // print(json.decode(response.body));
      final responseData=json.decode(response.body);
      if(responseData['error']!=null)
      {
        throw HttpException(message: responseData['error']['message']);
      }
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _token=responseData['idToken'];
      notifyListeners();
    }
    catch(error)
    {
      throw error;
    }
    
    
  }

}