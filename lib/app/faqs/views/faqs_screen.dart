import 'package:flutter/material.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<Map<String, String>> faqs = [
    {
      'question':
          'How can recruiters from companies post job openings on the platform?',
      'answer':
          'Recruiters can easily post job openings by creating an account on the platform. Once logged in, they can navigate to the "Post a Job" section, where they will be guided through a simple process to input job details, requirements, and any additional information.',
    },
    {
      'question':
          'How do job seekers apply for jobs, and what documents are required?',
      'answer':
          'Job seekers can apply for jobs by creating a profile on the platform and uploading their resume or CV. When applying for a specific job, they will have the option to upload their CV directly. The system will automatically screen the CVs, and successful candidates will move to the next stage of the application process.',
    },
    {
      'question':
          'How long does the CV screening process take, and when can applicants expect a response?',
      'answer':
          'The CV screening process is designed to provide results within a maximum of 6 hours after the document is uploaded. This ensures a swift response to job seekers, allowing them to progress to the next stage if successful or receive feedback promptly.',
    },
    {
      'question': 'What is the next step after the initial CV screening?',
      'answer':
          'Successful candidates in the CV screening phase will proceed to the second round, which involves answering Multiple Choice Questions (MCQs) related to the job. This step helps further assess the candidate\'s knowledge and skills. Those who pass this round will move on to the final interview stage.',
    },
    {
      'question':
          'How are on-site interviews scheduled for successful candidates?',
      'answer':
          'Candidates who successfully navigate the earlier rounds, including the MCQs, will have an on-site interview scheduled with the respective company. The platform will facilitate communication between recruiters and candidates to coordinate interview details, ensuring a seamless and efficient process.',
    },
  ];

  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: LightTheme.white),
          backgroundColor: LightTheme.primaryColor,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "FAQs",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ExpansionPanelList(
                elevation: 1,
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    _expandedIndex = _expandedIndex == index ? -1 : index;
                  });
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: const Color.fromARGB(255, 225, 227, 231),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        faqs[index]['answer']!,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          faqs[index]['question']!,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            color: LightTheme.secondaryColor,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    isExpanded: _expandedIndex == index,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
