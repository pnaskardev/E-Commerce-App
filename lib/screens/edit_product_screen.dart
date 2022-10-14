import 'package:ecommerce/providers/products.dart';
import 'package:ecommerce/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditProductScreen extends StatefulWidget 
{
  static const routeName='/edit-screen';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> 
{
  final _priceFocusNode=FocusNode();
  final _descriptionFocusNode=FocusNode();
  final _imageFocusNode=FocusNode();
  final _imageUrlController=TextEditingController();
  final _form=GlobalKey<FormState>();

  var _editedProduct=Product
  (
    id: '', 
    title: '', 
    description: '', 
    price: 0, 
    imageUrl: ''
  );


  @override
  void initState() 
  {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  var _initValue=
  {
    'id':'',
    'title':'',
    'description':'',
    'price':'',
    'imageUrl':'',

  };

  var _isInit=true;
  var _isLoading=false;
  @override
  void didChangeDependencies() 
  {
    if(_isInit==true)
    {
      final productId =ModalRoute.of(context)!.settings.arguments as String;
      if(productId!='')
      {
        _editedProduct=Provider.of<Products>(context,listen: false).findbyId(productId);
        _initValue=
        {
          'id':_editedProduct.id,
          'title':_editedProduct.title,
          'price':_editedProduct.price.toString(),
          'description':_editedProduct.description,
          // 'imageUrl':_editedProduct.imageUrl
          'imageUrl':''
        };
        _imageUrlController.text=_editedProduct.imageUrl;
      }
     
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  void dispose() 
  {
    super.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageUrlController.dispose();
  }

  void _updateImageUrl()
  {
    if(!_imageFocusNode.hasFocus)
    {
      if
      (
        _imageUrlController.text.isNotEmpty||
        !_imageUrlController.text.startsWith('http')||
        !_imageUrlController.text.startsWith('https') || 
        !_imageUrlController.text.endsWith('jpg') || 
        !_imageUrlController.text.endsWith('jpeg')
      )
      {
        return ;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async
  {
    final isValid=_form.currentState!.validate();
    if(!isValid)
    {
      return;
    }
    _form.currentState!.save();
    setState(() 
    {
      _isLoading=true;
    });
    if(_editedProduct.id!='')
    {
      Provider.of<Products>(context,listen: false).updateProduct
      (
        _editedProduct.id,
        _editedProduct
      );
      setState(() 
      {
        _isLoading=false;  
      });
      Navigator.of(context).pop();
    }
    else
    {
      try
      {
        await Provider.of<Products>(context,listen: false)
        .addProduct(_editedProduct);
      }
      catch (error)
      {
        await showDialog<Null>
         (
          context: context, 
          builder: (ctx)=>
            AlertDialog
            (
              title: const Text('An error has occured'),
              content: const Text('Something wet wrong'),
              actions: <Widget>
              [
                TextButton
                (
                  onPressed: ()
                  {
                    Navigator.of(ctx).pop();
                  }, 
                  child: const Text('Okay')
                )
              ],
            )
         );
      }
      finally
      {
        setState(() 
        {
          _isLoading=false;  
        });
        Navigator.of(context).pop();
      }
      
    }
    // print(_editedProduct.title);
    
  }

  @override
  Widget build(BuildContext context) 
  {
    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          title: const Text('Edit Product'),
          actions: 
          [
            IconButton
            (
              onPressed:_saveForm, 
              icon: const Icon(Icons.save)
            )
          ],
        ),
        body: _isLoading ? 
        const Center
        (
          child: CircularProgressIndicator(),
        ) : 
        SingleChildScrollView
        (
          child: Padding
          (
            padding: const EdgeInsets.all(8.0),
            child: Form
            (
              key: _form,
              child: Column
              (
                children: 
                [
                  TextFormField
                  (
                    initialValue: _initValue['title'],
                    decoration: const InputDecoration
                    (
                      labelText: 'Title',
    
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) 
                    {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) 
                    {
                      if(value!.isEmpty)
                      {
                        return 'Please provide a value';
                      }
                      return null;
                    },
                    onSaved: (value)
                    {
                      _editedProduct=Product
                      (
                        id: _editedProduct.id, 
                        title: value!, 
                        description:  _editedProduct.description, 
                        price: _editedProduct.price, 
                        imageUrl: _editedProduct.imageUrl,
                        isFav: _editedProduct.isFav
                      );
                    },
                  ),
                  TextFormField
                  (
                    initialValue: _initValue['price'],
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) 
                    {
                      FocusScope.of(context).requestFocus(_descriptionFocusNode);  
                    },
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Please enter a price';
                      }
                      if(double.tryParse(value)==null)
                      {
                        return 'Please enter a valid number';
                      }
                      if(double.parse(value)<=0)
                      {
                        return 'Please enter a number greater than 0';
                      }
                      return null;
                    },
                    onSaved: ((newValue) 
                    {
                      _editedProduct=Product
                      (
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        title: _editedProduct.title, 
                        description: _editedProduct.description, 
                        price: double.parse(newValue!), 
                        imageUrl: _editedProduct.imageUrl
                      ); 
                    }),
                  ),
                  TextFormField
                  (
                    initialValue: _initValue['description'],
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    validator: (value) 
                    {
                      if(value!.isEmpty)
                      {
                        return 'Please enter a description';
                      }  
                      if(value.length<10)
                      {
                        return 'Description should be atleast 10 characters long';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_)
                    {
                      _saveForm();
                    },
                    
                  
                    onSaved: ((newValue) 
                    {
                      _editedProduct=Product
                      (
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        title: _editedProduct.title, 
                        description: newValue.toString(), 
                        price: _editedProduct.price, 
                        imageUrl: newValue!
                      ); 
                    }),
                  ),
                  Row
                  (
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: 
                    [
                      Container
                      (
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8,right: 10),
                        decoration: BoxDecoration
                        (
                          border: Border.all(width: 1,color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty?const Text('Enter a URL'): FittedBox
                        (
                          fit: BoxFit.cover,
                          child: Image.network(_imageUrlController.text),
                        ),
                      ),
                      Expanded
                      (
                        child: TextFormField
                        (
                          decoration: const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageFocusNode,
                          onEditingComplete: () 
                          {
                            setState(() {});
                          },
                          validator: (value) 
                          {
                            if(value!.isEmpty)
                            {
                              return 'Please enter an Image URL';
                            }  
                            if(!value.startsWith('http')||!value.startsWith('https'))
                            {
                              return 'Please enter a valid image URL';
                            }
                            if(!value.endsWith('png') && !value.endsWith('.jpg'))
                            return null;
                          },
                          onFieldSubmitted: (_)
                          {
                            _saveForm();
                          },
                          
                        
                          onSaved: ((newValue) 
                          {
                            _editedProduct=Product
                            (
                              id: _editedProduct.id,
                              isFav: _editedProduct.isFav,
                              title: _editedProduct.title, 
                              description: _editedProduct.description, 
                              price: _editedProduct.price, 
                              imageUrl: newValue!
                            ); 
                          }),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}