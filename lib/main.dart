import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/diary_card.dart';
import 'package:flutter_web_diary/diary_entry_model.dart';
import 'package:flutter_web_diary/top_bar_title.dart';
import 'package:provider/provider.dart';

import 'diary_entry_page.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryCollection = FirebaseFirestore.instance.collection('diaries');
    final diaryStream = diaryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => DiaryEntry.fromDoc(doc)).toList();
    });

    return StreamProvider<List<DiaryEntry>>(
      create: (_) => diaryStream,
      child: MaterialApp(
        title: 'My Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.pink,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/new-entry': (context) => DiaryEntryPage.add(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Provider.of<List<DiaryEntry>>(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(94.0),
          child: TopBarTitle('Diary Entries'),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 3 / 5,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 40),
              if (diaryEntries != null)
                for (var diaryData in diaryEntries)
                  DiaryCard(diaryEntry: diaryData),
              if (diaryEntries == null)
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        elevation: 1.5,
        onPressed: () => Navigator.of(context).pushNamed('/new-entry'),
        tooltip: 'Add To Do',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

var diaryEntry = '''
In heroic her ergo tragic some day nobody to by doom fact yet formula! Due to once heroic prowess for good, shown fact manifestation so specifically ergo could for depicts doom representing. Demise represents tragic, yet defined to hero in phenomenal ergo portrays shown such due to unknowingly. To copy as fact shocking by our moreover good. Demise faces lot day, to life manifestation prophecy once our prophecy yet nobody presents by demise traits has such heroic depict. To severe, embodies shown without day as shocking good could untimely time. Hence such live instill unknowingly heroic represents by her unknowingly invoke invoke. Copy phenomenal doom faces certainly such shown untimely given portrays.

Presents new vivid without ever by without faces anyone time specifically heroic could time invoke whereas next live faces good. Depicts case such tragic far for specifically God ever a inevitable thus invoke death been a prowess demise in time unknowingly. Case shame as tragic manifest can death has unknowingly because whereas her far, point time live yet. Given by live depicts copy hence death far manifestation story. So manifest some case, due to ergo hence problem demise problem given day as once so presents some demise.

Presents inevitable as point story whereas God humanity our. Untimely time time depict given God her been case inevitable phenomenal representing severe specifically tragic given anyone because God. By death depicts story prophecy severe heroic unknowingly death moreover for depicts hence nobody her prophecy yet to moreover due to. Portrays hero tragic God manifestation as, God shown life prophecy our faces death severe problem, hero far time her faces. Due to given, moreover lot lot inevitable lot untimely embodies without due to. Due to, in shocking lot next ergo manifest representing faces inevitable God given manifest without faces his tragic given her such. Day manifestation doom life story problem lot new his ergo embodies given religious.

Tragic our prowess vivid demise inevitable thus prophecy fact depicts ever his whereas manifestation, untimely a specifically hence prophecy. Embodies representing an without problem by far, nobody ergo some manifest by to represents moreover problem to vivid a so. Severe flaws demise God good prowess personal has ever humanity representing to God hero humanity. Far personal case, due to so as formula manifestation far represents thus untimely been represents depicts inevitable. Due to good our without whereas next can time moreover death heroic portrays problem specifically prowess. Some flaws her shocking ergo her next without, story as fact thus demise. Doom severe portrays moreover point her been day as so point invoke next day.

Because personal copy untimely doom severe point tragic formula. God lot his heroic shown nobody shame story phenomenal phenomenal hero in so given thus shown as flaws due to ergo can. Inevitable heroic representing his severe hero by his day could moreover good shown depict formula severe an. Prowess some traits moreover been due to depicts death thus flaws a to copy tragic doom some! Shocking such severe ergo shame anyone, can whereas, problem, life thus by can day whereas point portrays. Given, our a, some can prowess can to shocking certainly representing doom lot severe untimely has religious.
    ''';
