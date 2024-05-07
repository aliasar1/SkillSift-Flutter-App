class Question {
  final String question;
  final List<String> choices;
  final int answer;
  final String difficultyLevel;

  Question({
    required this.question,
    required this.choices,
    required this.answer,
    required this.difficultyLevel,
  });
}

var questions = {
  "information_technology": [
    {
      "question":
          "What is the purpose of DNS (Domain Name System) in computer networks?",
      "choices": [
        "To encrypt data transmissions",
        "To manage network hardware",
        "To convert domain names to IP addresses",
        "To control access to websites"
      ],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the function of a firewall in network security?",
      "choices": [
        "To improve internet speed",
        "To block unwanted access to a network",
        "To encrypt data transmissions",
        "To provide physical protection for network hardware"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the difference between RAM and ROM in computers?",
      "choices": [
        "RAM is faster than ROM, but ROM has a larger storage capacity.",
        "All of the above",
        "RAM stores data temporarily, while ROM stores data permanently.",
        "RAM is used for running programs, while ROM stores the operating system."
      ],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the binary number system based on?",
      "choices": [
        "Base 16 (hexadecimal)",
        "Base 8 (octal)",
        "Base 10 (0-9)",
        "Base 2 (0s and 1s)"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What does HTTP stand for?",
      "choices": [
        "Hyper Texting Transfer Protocol",
        "High Tech Transfer Protocol",
        "High Tech Text Protocol",
        "Hyper Text Transfer Protocol"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the primary function of an operating system?",
      "choices": [
        "To protect against computer viruses",
        "To manage hardware resources and provide a platform for running software applications",
        "To browse the internet",
        "To play games"
      ],
      "answer": 1,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the difference between a compiler and an interpreter in programming languages?",
      "choices": [
        "Compilers are slower but more efficient, while interpreters are faster but less efficient.",
        "A compiler translates the entire code into machine code before execution, while an interpreter translates and executes code line by line.",
        "There is no difference; they are the same thing.",
        "A compiler is for high-level languages, while an interpreter is for low-level languages."
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the cloud in cloud computing?",
      "choices": [
        "A physical storage device for data",
        "A type of internet connection",
        "A software application",
        "A network of remote servers that provide on-demand computing resources"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the most common type of computer network attack?",
      "choices": [
        "Phishing",
        "Malware infection",
        "All of the above",
        "Denial-of-service attack (DoS)"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the time complexity of the bubble sort algorithm?",
      "choices": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the purpose of encapsulation in object-oriented programming (OOP)?",
      "choices": [
        "To organize code into objects",
        "To ensure data privacy and hide implementation details",
        "To allow inheritance between classes",
        "To provide polymorphism"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the role of the 'super' keyword in Java?",
      "choices": [
        "To call a superclass constructor",
        "To define a superclass",
        "To implement an interface",
        "To declare a variable"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "Which of the following is an advantage of using recursion?",
      "choices": [
        "Reduced memory consumption",
        "Improved code efficiency",
        "Simplified debugging process",
        "Easier code maintenance"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of a destructor in Python?",
      "choices": [
        "To initialize an object",
        "To release resources when an object is no longer needed",
        "To define a method",
        "To handle exceptions"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question":
          "What is the time complexity of the insertion sort algorithm?",
      "choices": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of inheritance in OOP?",
      "choices": [
        "To create objects",
        "To allow one class to acquire properties and behavior of another class",
        "To define constructors",
        "To handle exceptions"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question":
          "What is the main advantage of using a hash table data structure?",
      "choices": [
        "Constant-time access to elements",
        "Dynamic resizing",
        "Automatic sorting of elements",
        "Preservation of insertion order"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the difference between a linked list and an array?",
      "choices": [
        "Linked lists allow constant-time access to elements",
        "Arrays have dynamic size, while linked lists have fixed size",
        "Arrays store elements in contiguous memory locations, while linked lists do not",
        "Linked lists use less memory than arrays"
      ],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of the 'this' keyword in Java?",
      "choices": [
        "To call a superclass constructor",
        "To access a static variable",
        "To reference the current object",
        "To create an instance of a class"
      ],
      "answer": 2,
      "difficulty_level": "easy"
    },
    {
      "question": "What is the time complexity of the bubble sort algorithm?",
      "choices": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the purpose of encapsulation in object-oriented programming (OOP)?",
      "choices": [
        "To organize code into objects",
        "To ensure data privacy and hide implementation details",
        "To allow inheritance between classes",
        "To provide polymorphism"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the role of the 'super' keyword in Java?",
      "choices": [
        "To call a superclass constructor",
        "To define a superclass",
        "To implement an interface",
        "To declare a variable"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "Which of the following is an advantage of using recursion?",
      "choices": [
        "Reduced memory consumption",
        "Improved code efficiency",
        "Simplified debugging process",
        "Easier code maintenance"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of a destructor in Python?",
      "choices": [
        "To initialize an object",
        "To release resources when an object is no longer needed",
        "To define a method",
        "To handle exceptions"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question":
          "What is the time complexity of the insertion sort algorithm?",
      "choices": ["O(n)", "O(log n)", "O(n^2)", "O(1)"],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of inheritance in OOP?",
      "choices": [
        "To create objects",
        "To allow one class to acquire properties and behavior of another class",
        "To define constructors",
        "To handle exceptions"
      ],
      "answer": 1,
      "difficulty_level": "hard"
    },
    {
      "question":
          "What is the main advantage of using a hash table data structure?",
      "choices": [
        "Constant-time access to elements",
        "Dynamic resizing",
        "Automatic sorting of elements",
        "Preservation of insertion order"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the difference between a linked list and an array?",
      "choices": [
        "Linked lists allow constant-time access to elements",
        "Arrays have dynamic size, while linked lists have fixed size",
        "Arrays store elements in contiguous memory locations, while linked lists do not",
        "Linked lists use less memory than arrays"
      ],
      "answer": 2,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of the 'this' keyword in Java?",
      "choices": [
        "To call a superclass constructor",
        "To access a static variable",
        "To reference the current object",
        "To create an instance of a class"
      ],
      "answer": 2,
      "difficulty_level": "easy"
    },
  ]
};
