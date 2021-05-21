import 'package:Scrum/index.dart';

class TaskAdd extends StatefulWidget {
  @override
  _TaskAddState createState() => _TaskAddState();
}

enum type { Component, Animation, Prototype, Screen, Integration }

class _TaskAddState extends State<TaskAdd> {
  String desc;
  int id, priority, level, eta;
  bool assigned;
  type task = type.Component;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        shadowColor: AppTheme.appBarShadowColor,
        centerTitle: true,
        title: Text('Add Task', style: AppTheme.appBarStyle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ID',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  id = int.parse(val);
                },
              ),
              TextFormField(
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Priority',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  priority = int.parse(val);
                  print(priority);
                },
              ),
              TextFormField(
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Level',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  level = int.parse(val);
                  print(level);
                },
              ),
              TextFormField(
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ETA',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  eta = int.parse(val);
                  print(eta);
                },
              ),
              TextFormField(
                cursorColor: Theme.of(context).hintColor,
                cursorWidth: 0.7,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Description',
                  isDense: true,
                  labelStyle: AppTheme.secondaryTextStyle,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                onChanged: (String val) {
                  desc = val;
                  print(desc);
                },
              ),
              ListTile(
                title: const Text('Component'),
                leading: Radio(
                  value: type.Component,
                  groupValue: task,
                  onChanged: (type value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Animation'),
                leading: Radio(
                  value: type.Animation,
                  groupValue: task,
                  onChanged: (type value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Prototype'),
                leading: Radio(
                  value: type.Prototype,
                  groupValue: task,
                  onChanged: (type value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Screen'),
                leading: Radio(
                  value: type.Screen,
                  groupValue: task,
                  onChanged: (type value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Integration'),
                leading: Radio(
                  value: type.Integration,
                  groupValue: task,
                  onChanged: (type value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
              ),
              RaisedButton(
                child: Text('Add',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                color: AppTheme.primaryColor,
                onPressed: () {
                  Task tk = Task(
                    id: id,
                    assigned: false,
                    desc: desc,
                    eta: eta,
                    level: level,
                    priority: priority,
                    type: task.toString().substring(5),
                  );
                  locator<TaskModel>().addTask(tk);
                  locator<SqliteDatabaseService>().insertTask(tk);
                  tkkMap['Pending'] += 1;
                  hrsMap['Pending'] += tk.eta;
                  print('Task Add: ');
                  print(tkkMap);
                  print(hrsMap);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
