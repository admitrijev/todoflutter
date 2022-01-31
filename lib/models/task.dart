class Task {

  String name;
  bool isDone;
  bool isNew;

  Task({required this.name, this.isNew = false, this.isDone = false});

  void setNewDescription(value) {
    name = value;
  }

  void setAsNotNew() {
    isNew = false;
  }

  void toggleDone() {
    isDone = !isDone;
  }
}