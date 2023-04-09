import 'package:card_study_flutter/db/dbTopic.dart';
import 'package:card_study_flutter/models/topic.dart';
import 'package:flutter/material.dart';

class TopicInputWidget extends StatefulWidget {
  Topic? topic;
  TopicInputWidget({super.key, this.topic});

  @override
  _TopicInputWidgetState createState() => _TopicInputWidgetState();
}

class _TopicInputWidgetState extends State<TopicInputWidget> {
  final _formKey = GlobalKey<FormState>();
  late final int? _id = widget.topic?.id;
  late final int? _parentId = widget.topic?.parentId;
  late String _title = widget.topic?.title ?? "";
  late String _description = widget.topic?.description ?? '';
  late bool _isFavorite = widget.topic?.favorite ?? false;
  late int _priority = widget.topic?.priority ?? 1;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Do something with the topic data
      Topic topic = Topic(
          id: _id,
          parentId: _parentId,
          title: _title,
          description: _description,
          favorite: _isFavorite,
          priority: _priority);
      DBTopic.insert(topic);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Topic'),
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
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                initialValue: _title,
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                initialValue: _description,
                onSaved: (value) {
                  _description = value!;
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
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
