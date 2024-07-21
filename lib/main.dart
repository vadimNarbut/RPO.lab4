import 'package:flutter/material.dart';
import 'note.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesListScreen(),
    );
  }
}

class NotesListScreen extends StatelessWidget {
  final List<Note> notes = [
    Note(
      title: 'Заметка 1',
      content: 'Содержание заметки 1',
      lastEdited: DateTime.now(),
    ),
    // Добавьте больше заметок по необходимости
  ];

  @override
  Widget build(BuildContext context) { //Этот аннотационный метод указывает, что метод build переопределяет метод из родительского класса StatelessWidget
    return Scaffold( //это контейнер для базовой структуры визуального интерфейса приложения. Он предоставляет такие элементы, как AppBar, Drawer, FloatingActionButton и другие.
      appBar: AppBar( //это верхняя панель приложения. В данном случае она содержит заголовок “Заметки”.
        title: Text('Заметки'),
      ),
      body: ListView.builder( //это виджет, который создает прокручиваемый список элементов. Он принимает два параметра:
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index]; //Этот код извлекает заметку из списка notes по текущему индексу index.
          return ListTile( // это виджет, который представляет одну строку в списке. Он содержит:
            title: Text(note.title), //заголовок заметки.
            subtitle: Text(note.content), //содержание заметки.
            trailing: Text(note.lastEdited.toString()), // дата последнего редактирования заметки.
            onTap: () { //функция, которая вызывается при нажатии на элемент списка.
              Navigator.push( //используется для перехода на новый экран. Он принимает два параметра:
                context, //текущий контекст.
                MaterialPageRoute( //маршрут, который создает новый экран. В данном случае это экран
                  builder: (context) => NoteDetailScreen(note: note), //который принимает заметку в качестве параметра.
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton( //это плавающая кнопка действия, которая отображается в правом нижнем углу экрана. Она содержит:
        onPressed: () { //функция, которая вызывается при нажатии на кнопку. В данном случае она переходит на экран CreateNoteScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNoteScreen(),
            ),
          );
        },
        child: Icon(Icons.add),//иконка, отображаемая на кнопке (в данном случае это иконка добавления).
      ),
    );
  }
}

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование заметки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Содержание'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.note.title = _titleController.text;
                  widget.note.content = _contentController.text;
                  widget.note.lastEdited = DateTime.now();
                });
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateNoteScreen extends StatefulWidget {
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая заметка'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Содержание'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  title: _titleController.text,
                  content: _contentController.text,
                  lastEdited: DateTime.now(),
                );
                // Добавьте логику для сохранения новой заметки
                Navigator.pop(context);
              },
              child: Text('Создать'),
            ),
          ],
        ),
      ),
    );
  }
}