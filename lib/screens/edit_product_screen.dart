import 'package:flutter/material.dart';
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


  @override
  void initState() 
  {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView
      (
        child: Padding
        (
          padding: const EdgeInsets.all(8.0),
          child: Form
          (
            child: Column
            (
              children: 
              [
                TextFormField
                (
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) 
                  {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField
                (
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) 
                  {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);  
                  },
                ),
                TextFormField
                (
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
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
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}