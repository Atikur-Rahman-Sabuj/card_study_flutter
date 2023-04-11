import 'package:card_study_flutter/db/dbCard.dart';
import 'package:card_study_flutter/models/studyCard.dart';
import 'package:flutter/material.dart';

class CardInputWidget extends StatefulWidget {
  StudyCard? card;
  CardInputWidget({super.key, this.card});

  @override
  _CardInputWidgetState createState() => _CardInputWidgetState();
}

class _CardInputWidgetState extends State<CardInputWidget> {
  final _formKey = GlobalKey<FormState>();
  late final int? _id = widget.card?.id;
  late final int? _topicId = widget.card?.topicId;
  late String _frontTitle = widget.card?.frontTitle ?? "";
  late String _backTitle = widget.card?.backTitle ?? "";
  late String _frontDescription = widget.card?.frontDescription ?? '';
  late String _backDescription = widget.card?.backDescription ?? '';
  late bool _isFavorite = widget.card?.favorite ?? false;
  late int _priority = widget.card?.priority ?? 1;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      StudyCard card = StudyCard(
          id: _id,
          topicId: _topicId,
          frontTitle: _frontTitle,
          backTitle: _backTitle,
          frontDescription: _frontDescription,
          backDescription: _backDescription,
          favorite: _isFavorite,
          priority: _priority);
      if (card.id == null) {
        DBCard.insert(card);
      } else {
        DBCard.update(card);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.card == null ? 'Add' : 'Update'} Card'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Front Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter front title';
                  }
                  return null;
                },
                initialValue: _frontTitle,
                onSaved: (value) {
                  _frontTitle = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Front Description',
                ),
                maxLines: 3,
                minLines: 1,
                initialValue: _frontDescription,
                onSaved: (value) {
                  _frontDescription = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Back Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter back title';
                  }
                  return null;
                },
                initialValue: _backTitle,
                onSaved: (value) {
                  _backTitle = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Back Description',
                ),
                maxLines: 3,
                minLines: 1,
                initialValue: _backDescription,
                onSaved: (value) {
                  _backDescription = value!;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Favorite'),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Priority'),
                  DropdownButton<int>(
                    value: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Low'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('High'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.card == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
