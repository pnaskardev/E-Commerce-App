class HttpException implements Exception
{
  final String message;
  HttpException
  (
    {
      required this.message,

    }
  );

  @override
  String toString() 
  {
    // return super.toString();
    return message;
  }
}