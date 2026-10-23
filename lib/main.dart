import 'package:flutter/material.dart';
void main() {
runApp(const MyApp());
}
const purple = Color(0xFF7357E8);
const background = Color(0xFFF7F6FC);

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'FlashLearn',
theme: ThemeData(
useMaterial3: true,
scaffoldBackgroundColor: background,
colorScheme: ColorScheme.fromSeed(seedColor: purple),
appBarTheme: const AppBarTheme(
backgroundColor: background,
foregroundColor: Color(0xFF24213A),
elevation: 0,
),
),
home: const HomeScreen(),
);
}
}

class Flashcard {
String question;
String answer;
String category;

Flashcard(this.question, this.answer, this.category);
}

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final List<String> categories = [
'Programming',
'General Knowledge',
'Science',
'Aptitude',
];

final Map<String, IconData> categoryIcons = {
'Programming': Icons.code,
'General Knowledge': Icons.public,
'Science': Icons.science_outlined,
'Aptitude': Icons.psychology_outlined,
};

final List<Flashcard> cards = [
Flashcard('What is Flutter?', 'Flutter is a UI toolkit by Google for building applications.', 'Programming'),
Flashcard('What is Dart?', 'Dart is the programming language used by Flutter.', 'Programming'),
Flashcard('What is HTML?', 'HTML structures content on web pages.', 'Programming'),
Flashcard('What is CSS?', 'CSS styles and designs web pages.', 'Programming'),
Flashcard('What is a variable?', 'A variable stores a value that a program can use.', 'Programming'),
Flashcard('What is a function?', 'A reusable block of code that performs a task.', 'Programming'),
Flashcard('What is an array?', 'A data structure that stores multiple values.', 'Programming'),
Flashcard('What is Python?', 'Python is a high-level programming language.', 'Programming'),
Flashcard('What does CPU stand for?', 'Central Processing Unit.', 'Programming'),
Flashcard('What is an algorithm?', 'A sequence of steps to solve a problem.', 'Programming'),
Flashcard('What is the capital of India?', 'New Delhi.', 'General Knowledge'),
Flashcard('How many days are in a leap year?', '366 days.', 'General Knowledge'),
Flashcard('Which is the largest ocean?', 'The Pacific Ocean.', 'General Knowledge'),
Flashcard('How many continents are there?', 'Seven continents.', 'General Knowledge'),
Flashcard('What is the national animal of India?', 'The Bengal tiger.', 'General Knowledge'),
Flashcard('Which planet is called the Red Planet?', 'Mars.', 'Science'),
Flashcard('What is the chemical formula of water?', 'H₂O.', 'Science'),
Flashcard('Which planet is closest to the Sun?', 'Mercury.', 'Science'),
Flashcard('What gas do plants absorb?', 'Carbon dioxide.', 'Science'),
Flashcard('What is the boiling point of water at sea level?', '100°C.', 'Science'),
Flashcard('What is the value of 12 × 12?', '144.', 'Aptitude'),
Flashcard('What is 25% of 200?', '50.', 'Aptitude'),
Flashcard('What is the square of 9?', '81.', 'Aptitude'),
Flashcard('How many minutes are in 2 hours?', '120 minutes.', 'Aptitude'),
Flashcard('If 5 pens cost ₹50, what is one pen worth?', '₹10.', 'Aptitude'),
Flashcard('What is the value of 15 + 27?', '42.', 'Aptitude'),
Flashcard('What is the opposite of increase?', 'Decrease.', 'General Knowledge'),
Flashcard('Which organ pumps blood?', 'The heart.', 'Science'),
Flashcard('What does URL stand for?', 'Uniform Resource Locator.', 'Programming'),
Flashcard('How many sides does a hexagon have?', 'Six.', 'Aptitude'),
];

String searchText = '';

List<Flashcard> get filteredCards {
return cards.where((card) {
return card.question.toLowerCase().contains(searchText.toLowerCase()) ||
card.category.toLowerCase().contains(searchText.toLowerCase());
}).toList();
}

void addCategory() {
final controller = TextEditingController();

showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text('Create Category'),
content: TextField(
controller: controller,
autofocus: true,
decoration: const InputDecoration(
hintText: 'Enter category name',
prefixIcon: Icon(Icons.category_outlined),
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
final name = controller.text.trim();

if (name.isEmpty) return;

if (categories.any(
(category) => category.toLowerCase() == name.toLowerCase(),
)) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Category already exists!')),
);
return;
}

setState(() {
categories.add(name);
categoryIcons[name] = Icons.style_outlined;
});

Navigator.pop(dialogContext);
},
child: const Text('Create'),
),
],
),
);
}

void addCard({String? category}) {
showCardDialog(category: category);
}

void showCardDialog({Flashcard? card, String? category}) {
final questionController = TextEditingController(
text: card?.question ?? '',
);
final answerController = TextEditingController(
text: card?.answer ?? '',
);

String selectedCategory = card?.category ??
(category != null && categories.contains(category)
? category
    : categories.first);

showDialog(
context: context,
builder: (dialogContext) {
return StatefulBuilder(
builder: (context, updateDialog) => AlertDialog(
title: Text(card == null ? 'New Flashcard' : 'Edit Flashcard'),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: questionController,
maxLines: 3,
decoration: const InputDecoration(
labelText: 'Question',
hintText: 'Enter your question',
alignLabelWithHint: true,
),
),
const SizedBox(height: 12),
TextField(
controller: answerController,
maxLines: 4,
decoration: const InputDecoration(
labelText: 'Answer',
hintText: 'Enter the answer',
alignLabelWithHint: true,
),
),
const SizedBox(height: 16),
DropdownButtonFormField<String>(
value: selectedCategory,
decoration: const InputDecoration(
labelText: 'Category',
),
items: categories.map((name) {
return DropdownMenuItem(
value: name,
child: Text(name),
);
}).toList(),
onChanged: (value) {
if (value != null) {
updateDialog(() {
selectedCategory = value;
});
}
},
),
],
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
final question = questionController.text.trim();
final answer = answerController.text.trim();

if (question.isEmpty || answer.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Please enter both question and answer.'),
),
);
return;
}

setState(() {
if (card == null) {
cards.add(
Flashcard(question, answer, selectedCategory),
);
} else {
card.question = question;
card.answer = answer;
card.category = selectedCategory;
}
});

Navigator.pop(dialogContext);
},
child: Text(card == null ? 'Add Card' : 'Save Changes'),
),
],
),
);
},
);
}

void deleteCard(Flashcard card) {
showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text('Delete Flashcard?'),
content: const Text(
'This flashcard will be removed from the current session.',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
setState(() {
cards.remove(card);
});
Navigator.pop(dialogContext);
},
child: const Text('Delete'),
),
],
),
);
}

void openCategory(String category) {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => StudyScreen(
category: category,
cards: cards,
onAdd: () => addCard(category: category),
onEdit: (card) => showCardDialog(card: card),
onDelete: deleteCard,
),
),
).then((_) => setState(() {}));
}

@override
Widget build(BuildContext context) {
final programmingCount =
cards.where((card) => card.category == 'Programming').length;

return Scaffold(
appBar: AppBar(
title: const Text(
'FlashLearn',
style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
),
actions: [
IconButton(
onPressed: addCategory,
tooltip: 'Create category',
icon: const Icon(Icons.create_new_folder_outlined),
),
const SizedBox(width: 8),
],
),
floatingActionButton: FloatingActionButton.extended(
onPressed: () => addCard(),
backgroundColor: purple,
foregroundColor: Colors.white,
icon: const Icon(Icons.add),
label: const Text('New Card'),
),
body: SafeArea(
child: ListView(
padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
children: [
Container(
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [Color(0xFF8065EE), Color(0xFF5940C7)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(26),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'YOUR DAILY STUDY SPACE ✨',
style: TextStyle(
color: Colors.white70,
fontSize: 11,
letterSpacing: 1.5,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 14),
const Text(
'Learn something\nnew today.',
style: TextStyle(
color: Colors.white,
fontSize: 29,
height: 1.2,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 12),
Text(
'${cards.length} flashcards ready for you',
style: const TextStyle(
color: Colors.white70,
fontSize: 14,
),
),
const SizedBox(height: 20),
Row(
children: [
Expanded(
child: ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: purple,
padding: const EdgeInsets.symmetric(vertical: 13),
),
onPressed: () {
if (cards.isNotEmpty) {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => StudyScreen(
category: 'All Cards',
cards: cards,
onAdd: () => addCard(),
onEdit: (card) =>
showCardDialog(card: card),
onDelete: deleteCard,
),
),
).then((_) => setState(() {}));
}
},
icon: const Icon(Icons.play_arrow_rounded),
label: const Text('Start Learning'),
),
),
],
),
],
),
),
const SizedBox(height: 25),
TextField(
onChanged: (value) => setState(() => searchText = value),
decoration: InputDecoration(
hintText: 'Search flashcards or categories...',
prefixIcon: const Icon(Icons.search),
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(17),
borderSide: BorderSide.none,
),
),
),
const SizedBox(height: 25),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Study Categories',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
TextButton.icon(
onPressed: addCategory,
icon: const Icon(Icons.add, size: 18),
label: const Text('Add'),
),
],
),
const SizedBox(height: 10),
GridView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
itemCount: categories
    .where(
(category) => category.toLowerCase().contains(
searchText.toLowerCase(),
),
)
    .length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 12,
mainAxisSpacing: 12,
childAspectRatio: 1.12,
),
itemBuilder: (context, index) {
final category = categories.where(
(category) => category.toLowerCase().contains(
searchText.toLowerCase(),
),
).toList()[index];

final count = cards
    .where((card) => card.category == category)
    .length;

final icon =
categoryIcons[category] ?? Icons.style_outlined;

return InkWell(
onTap: () => openCategory(category),
borderRadius: BorderRadius.circular(22),
child: Container(
padding: const EdgeInsets.all(17),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(22),
border: Border.all(color: const Color(0xFFECE8F8)),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
padding: const EdgeInsets.all(11),
decoration: BoxDecoration(
color: const Color(0xFFEFEAFF),
borderRadius: BorderRadius.circular(14),
),
child: Icon(icon, color: purple, size: 25),
),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
category,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 15,
),
),
const SizedBox(height: 5),
Text(
'$count flashcards',
style: const TextStyle(
color: Colors.grey,
fontSize: 12,
),
),
],
),
],
),
),
);
},
),
if (searchText.isNotEmpty) ...[
const SizedBox(height: 24),
const Text(
'Matching flashcards',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
...filteredCards.map(
(card) => Card(
color: Colors.white,
child: ListTile(
title: Text(card.question),
subtitle: Text(card.category),
trailing: const Icon(Icons.chevron_right),
onTap: () => openCategory(card.category),
),
),
),
],
const SizedBox(height: 20),
Container(
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: const Color(0xFFEDE8FF),
borderRadius: BorderRadius.circular(20),
),
child: Row(
children: [
const Icon(Icons.auto_awesome, color: purple, size: 32),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Small steps, big progress!',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 4),
Text(
'$programmingCount programming cards to explore.',
style: const TextStyle(fontSize: 12),
),
],
),
),
],
),
),
],
),
),
);
}
}

class StudyScreen extends StatefulWidget {
final String category;
final List<Flashcard> cards;
final VoidCallback onAdd;
final Function(Flashcard) onEdit;
final Function(Flashcard) onDelete;

const StudyScreen({
super.key,
required this.category,
required this.cards,
required this.onAdd,
required this.onEdit,
required this.onDelete,
});

@override
State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
int index = 0;
bool showAnswer = false;

List<Flashcard> get studyCards {
if (widget.category == 'All Cards') {
return List.from(widget.cards);
}

return widget.cards
    .where((card) => card.category == widget.category)
    .toList();
}

@override
Widget build(BuildContext context) {
final currentCards = studyCards;

return Scaffold(
appBar: AppBar(
title: Text(widget.category),
actions: [
IconButton(
onPressed: widget.onAdd,
tooltip: 'Add flashcard',
icon: const Icon(Icons.add_circle_outline),
),
],
),
body: currentCards.isEmpty
? Center(
child: Padding(
padding: const EdgeInsets.all(24),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.style_outlined,
size: 70,
color: purple,
),
const SizedBox(height: 18),
const Text(
'No cards in this category yet.',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 18),
),
const SizedBox(height: 15),
ElevatedButton.icon(
onPressed: widget.onAdd,
icon: const Icon(Icons.add),
label: const Text('Create Flashcard'),
),
],
),
),
)
    : Builder(
builder: (context) {
if (index >= currentCards.length) {
index = currentCards.length - 1;
}

final card = currentCards[index];

return Padding(
padding: const EdgeInsets.all(22),
child: Column(
children: [
const SizedBox(height: 15),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
'CARD ${index + 1} OF ${currentCards.length}',
style: const TextStyle(
color: purple,
fontWeight: FontWeight.bold,
letterSpacing: 1.2,
),
),
IconButton(
onPressed: () => widget.onEdit(card),
icon: const Icon(Icons.edit_outlined),
tooltip: 'Edit flashcard',
),
],
),
const SizedBox(height: 10),
ClipRRect(
borderRadius: BorderRadius.circular(10),
child: LinearProgressIndicator(
value: (index + 1) / currentCards.length,
minHeight: 7,
backgroundColor: const Color(0xFFE5DFF7),
color: purple,
),
),
const SizedBox(height: 30),
Expanded(
child: GestureDetector(
onTap: () {
setState(() {
showAnswer = !showAnswer;
});
},
child: AnimatedSwitcher(
duration: const Duration(milliseconds: 250),
child: Container(
key: ValueKey(
'${card.question}_$showAnswer',
),
width: double.infinity,
padding: const EdgeInsets.all(25),
decoration: BoxDecoration(
gradient: LinearGradient(
colors: showAnswer
? const [
Color(0xFFE5F8EE),
Colors.white,
]
    : const [
Color(0xFFECE6FF),
Colors.white,
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(30),
border: Border.all(
color: const Color(0xFFE2DCF7),
),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
showAnswer
? Icons.lightbulb_rounded
    : Icons.style_rounded,
size: 58,
color: showAnswer
? Colors.green
    : purple,
),
const SizedBox(height: 28),
Text(
showAnswer ? 'ANSWER' : 'QUESTION',
style: const TextStyle(
letterSpacing: 2,
fontSize: 12,
fontWeight: FontWeight.bold,
color: Colors.grey,
),
),
const SizedBox(height: 16),
Text(
showAnswer
? card.answer
    : card.question,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 23,
height: 1.5,
fontWeight: FontWeight.bold,
color: Color(0xFF292440),
),
),
const SizedBox(height: 28),
Text(
showAnswer
? 'Tap to see question'
    : 'Tap the card to reveal answer',
style: const TextStyle(
color: Colors.grey,
fontSize: 12,
),
),
],
),
),
),
),
),
const SizedBox(height: 20),
Row(
children: [
Expanded(
child: OutlinedButton.icon(
onPressed: () {
if (index > 0) {
setState(() {
index--;
showAnswer = false;
});
}
},
icon: const Icon(Icons.arrow_back),
label: const Text('Previous'),
style: OutlinedButton.styleFrom(
padding:
const EdgeInsets.symmetric(vertical: 15),
),
),
),
const SizedBox(width: 14),
Expanded(
child: ElevatedButton.icon(
onPressed: () {
if (index < currentCards.length - 1) {
setState(() {
index++;
showAnswer = false;
});
} else {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'You reached the last flashcard!',
),
),
);
}
},
icon: const Icon(Icons.arrow_forward),
label: const Text('Next'),
style: ElevatedButton.styleFrom(
backgroundColor: purple,
foregroundColor: Colors.white,
padding:
const EdgeInsets.symmetric(vertical: 15),
),
),
),
],
),
const SizedBox(height: 10),
TextButton.icon(
onPressed: () => widget.onDelete(card),
icon: const Icon(Icons.delete_outline),
label: const Text('Delete this card'),
style: TextButton.styleFrom(
foregroundColor: Colors.redAccent,
),
),
const SizedBox(height: 5),
],
),
);
},
),
);
}
}
