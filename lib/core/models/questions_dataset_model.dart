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
        "A) To encrypt data transmissions",
        "B) To convert domain names to IP addresses",
        "C) To manage network hardware",
        "D) To control access to websites"
      ],
      "answer": 1,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the function of a firewall in network security?",
      "choices": [
        "A) To block unwanted access to a network",
        "B) To provide physical protection for network hardware",
        "C) To improve internet speed",
        "D) To encrypt data transmissions"
      ],
      "answer": 0,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the difference between RAM and ROM in computers?",
      "choices": [
        "A) RAM stores data temporarily, while ROM stores data permanently.",
        "B) RAM is faster than ROM, but ROM has a larger storage capacity.",
        "C) RAM is used for running programs, while ROM stores the operating system.",
        "D) All of the above"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What does CPU stand for?",
      "choices": [
        "A) Central Processing Unit",
        "B) Computerized Processing Unit",
        "C) Centralized Programming Unit",
        "D) Coding Processing Unit"
      ],
      "answer": 0,
      "difficulty_level": "easy"
    },
    {
      "question": "What is the binary number system based on?",
      "choices": [
        "A) Base 2 (0s and 1s)",
        "B) Base 10 (0-9)",
        "C) Base 16 (hexadecimal)",
        "D) Base 8 (octal)"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What does HTTP stand for?",
      "choices": [
        "A) Hyper Text Transfer Protocol",
        "B) High Tech Transfer Protocol",
        "C) Hyper Texting Transfer Protocol",
        "D) High Tech Text Protocol"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the primary function of an operating system?",
      "choices": [
        "A) To manage hardware resources and provide a platform for running software applications",
        "B) To browse the internet",
        "C) To protect against computer viruses",
        "D) To play games"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the difference between a compiler and an interpreter in programming languages?",
      "choices": [
        "A) A compiler translates the entire code into machine code before execution, while an interpreter translates and executes code line by line.",
        "B) A compiler is for high-level languages, while an interpreter is for low-level languages.",
        "C) Compilers are slower but more efficient, while interpreters are faster but less efficient.",
        "D) There is no difference; they are the same thing."
      ],
      "answer": 0,
      "difficulty_level": "hard"
    },
    {
      "question": "What is the cloud in cloud computing?",
      "choices": [
        "A) A network of remote servers that provide on-demand computing resources",
        "B) A physical storage device for data",
        "C) A type of internet connection",
        "D) A software application"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the most common type of computer network attack?",
      "choices": [
        "A) Phishing",
        "B) Denial-of-service attack (DoS)",
        "C) Malware infection",
        "D) All of the above"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of a CAPTCHA test?",
      "choices": [
        "A) To test a user's knowledge of a particular subject",
        "B) To differentiate between humans and bots",
        "C) To encrypt user data",
        "D) To improve website loading speed"
      ],
      "answer": 1,
      "difficulty_level": "medium"
    },
    {
      "question": "What does GHz stand for in computer processing speed?",
      "choices": [
        "A) Gigahertz (billions of cycles per second)",
        "B) Gigabyte (billions of bytes)",
        "C) Graphical Processing Unit",
        "D) Graphics per Hour"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the difference between software and hardware?",
      "choices": [
        "A) Software is intangible instructions that tell hardware what to do, while hardware is the physical components of a computer.",
        "B) Software is for entertainment purposes, while hardware is for work applications.",
        "C) Software is slower than hardware, while hardware is faster.",
        "D) There is no difference; they are the same thing."
      ],
      "answer": 0,
      "difficulty_level": "easy"
    },
    {
      "question":
          "What is the name of the first commercially available personal computer?",
      "choices": [
        "A) Apple I",
        "B) IBM PC",
        "C) Commodore 64",
        "D) Altair 8800"
      ],
      "answer": 3,
      "difficulty_level": "hard"
    },
    {
      "question": "What does the acronym USB stand for?",
      "choices": [
        "A) Universal Serial Bus",
        "B) Unique Serial Bridge",
        "C) Unified Standard Bridge",
        "D) Ultra-Speed Bus"
      ],
      "answer": 0,
      "difficulty_level": "easy"
    },
    {
      "question":
          "What is the difference between a web browser and a search engine?",
      "choices": [
        "A) A web browser retrieves information from websites based on user queries, while a search engine displays websites.",
        "B) A web browser is a type of software, while a search engine is a website.",
        "C) Web browsers are faster than search engines.",
        "D) There is no difference; they are the same thing."
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of cookies in web browsing?",
      "choices": [
        "A) To track user activity and preferences on websites",
        "B) To store downloaded files",
        "C) To improve internet speed",
        "D) To protect user privacy"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the process of encrypting data called?",
      "choices": [
        "A) Encryption",
        "B) Decryption",
        "C) Encoding",
        "D) Decoding"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is a common programming language used for web development?",
      "choices": [
        "A) HTML",
        "B) JavaScript",
        "C) Python",
        "D) All of the above"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question": "What does AI stand for?",
      "choices": [
        "A) Artificial Intelligence",
        "B) Advanced Interface",
        "C) Automated Information",
        "D) Algorithmic Intelligence"
      ],
      "answer": 0,
      "difficulty_level": "easy"
    },
    {
      "question":
          "What is the difference between a router and a modem in a network?",
      "choices": [
        "A) A router directs data traffic within a network, while a modem connects the network to the internet service provider.",
        "B) Routers are faster than modems.",
        "C) Modems are used for wireless connections, while routers are for wired connections.",
        "D) There is no difference; they are the same thing."
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What does VPN stand for?",
      "choices": [
        "A) Virtual Private Network",
        "B) Very Public Network",
        "C) Verified Public Access",
        "D) Visible Private Network"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What is the purpose of an operating system update?",
      "choices": [
        "A) To fix bugs and security vulnerabilities",
        "B) To change the look and feel of the user interface",
        "C) To slow down the computer",
        "D) To install new software applications"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is a common type of cybersecurity threat that involves tricking users into revealing personal information?",
      "choices": [
        "A) Phishing",
        "B) Denial-of-service attack (DoS)",
        "C) Malware infection",
        "D) Spyware"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question": "What does the term 'open source' software refer to?",
      "choices": [
        "A) Software with freely available source code that can be modified and distributed",
        "B) Software that is pre-installed on a computer and cannot be removed",
        "C) Software that is only available for a limited time",
        "D) Software that requires a subscription fee"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the difference between a .jpg and a .png image file format?",
      "choices": [
        "A) .jpg images are better suited for photos with a lot of color variation, while .png images are better for graphics with sharp lines and solid colors.",
        "B) .jpg images are larger in size than .png images.",
        "C) .png images can support transparency, while .jpg images cannot.",
        "D) All of the above"
      ],
      "answer": 3,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the name of the global network of interconnected computer networks?",
      "choices": [
        "A) The Web",
        "B) The Internet",
        "C) The Cloud",
        "D) The World Wide Web"
      ],
      "answer": 1,
      "difficulty_level": "easy"
    },
    {
      "question": "What is a common use case for blockchain technology?",
      "choices": [
        "A) Securely recording transactions and tracking ownership of digital assets",
        "B) Speeding up internet browsing",
        "C) Protecting against computer viruses",
        "D) Creating realistic video game graphics"
      ],
      "answer": 0,
      "difficulty_level": "hard"
    },
    {
      "question":
          "What is the difference between a website and a web application?",
      "choices": [
        "A) A website is a collection of web pages that may offer static information, while a web application is more interactive and allows users to perform actions.",
        "B) Websites are accessed through a web browser, while web applications can be accessed through a browser or downloaded as software.",
        "C) Websites are for personal use, while web applications are for business use.",
        "D) There is no difference; they are the same thing."
      ],
      "answer": 0,
      "difficulty_level": "medium"
    },
    {
      "question":
          "What is the purpose of a graphics processing unit (GPU) in a computer?",
      "choices": [
        "A) To handle tasks that require intensive graphical processing, such as video editing and gaming",
        "B) To store data",
        "C) To connect to the internet",
        "D) To manage system processes"
      ],
      "answer": 0,
      "difficulty_level": "medium"
    }
  ]
};
