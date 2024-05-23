import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/pages/home.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double _rating = 3;
  bool _isRatingSubmitted = false;

  Future<void> _submitRating() async {
  try {
    var response = await http.post(
      Uri.parse('http://192.168.0.102/kejaksaan_server/rating.php'),
      body: {
        'rating': _rating.toString(),
      },
    );
    
    if (response.statusCode == 200) {
      setState(() {
        _isRatingSubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rating submitted successfully')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false,
      );
    } else {
      throw Exception('Failed to submit rating');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isRatingSubmitted ? null : _submitRating,
            child: Text('Submit Rating'),
          ),
        ],
      ),
    );
  }
}
