import 'package:flutter/material.dart';
import 'package:flutter_library_task/Providers/tech_form.dart';
import 'package:flutter_library_task/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

final formProvider = ChangeNotifierProvider<FormModel>((ref) => FormModel());

class MyForm extends StatelessWidget {
  String selectedOption = "Option default";

  MyForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF075995),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Technical Support',
          style: TextStyle(
              color: Color(0xff075995),
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: String.fromEnvironment("poppins")),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(builder: (context, WidgetRef ref, child) {
            final form = ref.watch(formProvider);
            return Form(
              key: form.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Name',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'please enter your name here',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff075995),
                            width: 5,
                          ))),
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.required(),
                      onSaved: (value) {
                        form.name = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'please enter your email here',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff075995),
                            width: 5,
                          ))),
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.email(),
                        FormBuilderValidators.required()
                      ]),
                      onSaved: (value) {
                        form.email = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Issue topic',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff075995),
                          width: 5,
                        )),
                        labelText: '',
                      ),
                      value: selectedOption,
                      items: const [
                        DropdownMenuItem(
                          value: 'Incorrect billing or payment amount.',
                          child: Text(
                            'Incorrect billing or payment amount.',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Broken hyperlink or payment.',
                          child: Text(
                            'Broken hyperlink or payment.',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              'Login credentials not recognized or forgotten',
                          child: Text(
                            'Login credentials not recognized or forgotten',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Slow website loading or server timeouts',
                          child: Text(
                            'Slow website loading or server timeouts',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                        DropdownMenuItem(
                          value:
                              'Unable to access specific website features or functionality',
                          child: Text(
                            'Unable to access specific website features or functionality',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Option default',
                          child: Text(
                            'Select the issue topic',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: String.fromEnvironment("poppins")),
                          ),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.required(),
                      onSaved: (value) {
                        form.issueTopic = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Issue description',
                    style: TextStyle(
                        color: Color(0xff009BA6),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: String.fromEnvironment("poppins")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: TextFormField(
                      minLines: 5,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                          hintText: ' please tell us about your problem',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff075995),
                            width: 5,
                          ))),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.always,
                      validator: FormBuilderValidators.required(),
                      onSaved: (value) {
                        form.issueDescription = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        form.submitForm();
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen(
                                        yourName: 'moath asfour',
                                      )));
                        }
                      },
                      child: const Text('Submit'),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 2, 23, 41),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
