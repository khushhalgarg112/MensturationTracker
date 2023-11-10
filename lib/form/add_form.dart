import 'package:flutter/material.dart';
import '../db/period_data_model.dart';
import '../src/theme.dart';
import 'package:hive/hive.dart';

// hive box
const periodDataBox = 'periodDataBox';

//*********** AddPeriod: Page for entering data of new period ***********
class AddPeriod extends StatelessWidget {
  const AddPeriod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* AppBar */
      appBar: AppBar(
        title: const Text('Add data'),
      ),
      resizeToAvoidBottomInset: false,
      /* body */
      body: const AddPeriodDataForm(),
    );
  }
}

//*********** PeriodDataForm: form for entering period data ***********
class AddPeriodDataForm extends StatefulWidget {
  const AddPeriodDataForm({Key? key}) : super(key: key);

  @override
  _AddPeriodDataFormState createState() => _AddPeriodDataFormState();
}

class _AddPeriodDataFormState extends State<AddPeriodDataForm> {
  final _formKey = GlobalKey<FormState>();

  // date picker
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked == null) {
      return;
    }
    // changing date in ui
    setState(() {
      selectedDate = picked;
    });
  }

  // flow
  int _flowValue = 0;

  // symptoms
  bool? _symptomsCramps = false;
  bool? _symptomsBreakouts = false;
  bool? _symptomsTenderBreasts = false;
  bool? _symptomsFatigue = false;
  bool? _symptomsBloating = false;
  bool? _symptomsHeadache = false;

  // note
  final myController = TextEditingController();

  // onSubmitForm
  final box = Hive.box<PeriodData>(periodDataBox);
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool doesExist = false;

      for (var element in box.values) {
        // same date should not be repeated
        if (selectedDate.month == element.periodDate.month &&
            selectedDate.day == element.periodDate.day &&
            selectedDate.year == element.periodDate.year) {
          doesExist = true;
          break;
        }
      }
      if (doesExist) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Date Already exists!'),
          ),
        );
        return;
      }

      final newPeriodData = PeriodData(
          selectedDate,
          [
            _symptomsCramps!,
            _symptomsBreakouts!,
            _symptomsTenderBreasts!,
            _symptomsFatigue!,
            _symptomsBloating!,
            _symptomsHeadache!
          ],
          myController.text,
          _flowValue);

      box.add(newPeriodData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted')),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /* Date picker */
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OutlinedButton(
                    onPressed: () => _selectDate(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.date_range),
                        Text('Select Date')
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            /* Flow  */
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Flow",
                  style: titleStyle,
                ),
              ],
            ),
            Slider(
              value: _flowValue.toDouble(),
              max: 5,
              min: 0,
              divisions: 5,
              label: _flowValue.toString(),
              onChanged: (val) {
                // on flow changed
                setState(() {
                  _flowValue = val.toInt();
                });
              },
            ),
            /* Symptoms */
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Symptoms",
                  style: titleStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    /* Symptom: Cramp */
                    Row(
                      children: [
                        const Text("Cramps: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsCramps,
                          onChanged: (value) {
                            setState(() {
                              _symptomsCramps = value;
                            });
                          },
                        ),
                      ],
                    ),
                    /* Symptom: Breakouts */
                    Row(
                      children: [
                        const Text("Breakouts: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsBreakouts,
                          onChanged: (value) {
                            setState(() {
                              _symptomsBreakouts = value;
                            });
                          },
                        ),
                      ],
                    ),
                    /* Symptom: Tender Breasts */
                    Row(
                      children: [
                        const Text("Tender Breasts: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsTenderBreasts,
                          onChanged: (value) {
                            setState(() {
                              _symptomsTenderBreasts = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    /* Symptom: Fatigue */
                    Row(
                      children: [
                        const Text("Fatigue: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsFatigue,
                          onChanged: (value) {
                            setState(() {
                              _symptomsFatigue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    /* Symptom: Bloating */
                    Row(
                      children: [
                        const Text("Bloating: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsBloating,
                          onChanged: (value) {
                            setState(() {
                              _symptomsBloating = value;
                            });
                          },
                        ),
                      ],
                    ),
                    /* Symptom: Headache */
                    Row(
                      children: [
                        const Text("Headache: "),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: _symptomsHeadache,
                          onChanged: (value) {
                            setState(() {
                              _symptomsHeadache = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            /* Note */
            TextFormField(
              controller: myController,
              validator: (value) {},
              decoration: const InputDecoration(
                label: Text('Note: '),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /* Submit button */
            SizedBox(
              height: 45,
              width: 130,
              // decoration: BoxDecoration( color: Colors.blue, borderRadius: BorderRadius.circular(30),),
              child: Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    "Submit",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
