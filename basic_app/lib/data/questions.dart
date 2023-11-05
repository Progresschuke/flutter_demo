import 'package:basic_app/model/quiz_question.dart';
import 'package:flutter/material.dart';

const availableCategories = [
  Category(
    title: 'General Knowledge',
    id: 'c1',
    color: Color.fromARGB(255, 107, 97, 97),
    icon: Icon(Icons.import_contacts_outlined, size: 25),
  ),
  Category(
    title: 'Pure Sciences',
    id: 'c2',
    color: Color.fromARGB(255, 44, 48, 59),
    icon: Icon(Icons.biotech_outlined, size: 30),
  ),
  Category(
    title: 'Advanced Studies',
    id: 'c3',
    color: Color.fromARGB(255, 81, 27, 94),
    icon: Icon(Icons.psychology_alt_outlined, size: 28),
  ),
  Category(
    title: 'Basic Science',
    id: 'c4',
    color: Color.fromARGB(255, 3, 85, 71),
    icon: Icon(Icons.science_outlined, size: 28),
  )
];

const questions = [
  QuizQuestion(
      'What are the main building blocks of Flutter UIs',
      [
        'Widgets',
        'Components',
        'Blocks',
        'Functions',
      ],
      'c2'),
  QuizQuestion(
      'How are Flutter UIs built?',
      [
        'By combining widgets in code',
        'By combining widgets in a visual editor',
        'By defining widgets in config files',
        'By using XCode for iOS and Android Studio for Android',
      ],
      'c1'),
  QuizQuestion(
    ' What is the PH of H2O?',
    [
      '7',
      '6',
      '8',
      '9',
    ],
    'c2',
  ),
  QuizQuestion(
    '  Which of the following gas is reduced in the reduction process?',
    [
      'Hydrogen',
      'Helium',
      'Carbon',
      'Oxygen',
    ],
    'c2',
  ),
  QuizQuestion(
    ' Which of the following compound is mainly used in hand sanitizer?',
    [
      'Alcohol',
      'Ketone',
      'Acetic acid',
      'Aldehyde',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the S.I unit of frequency?',
    [
      'Hertz',
      'Diopter',
      'Second',
      'Meter',
    ],
    'c2',
  ),
  QuizQuestion(
    'Acid turns blue litmus paper into which color?',
    [
      'Red',
      'Blue',
      'Black',
      'Orange',
    ],
    'c2',
  ),
  QuizQuestion(
    ' Which of the following enzymes is not present in the human stomach?',
    [
      'Trypsin',
      'Pepsin',
      'Mucus',
      'Hydrochloric acid',
    ],
    'c2',
  ),
  QuizQuestion(
    ' Which of the following gland is present in the human mouth?',
    [
      'Salivary',
      'Gonads',
      'Pituitary',
      'Adrenal',
    ],
    'c2',
  ),
  QuizQuestion(
    ' Name the gland which is present above our kidneys?',
    [
      'Adrenal',
      'Pituitary',
      'Gonads',
      'Salivary',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the basic unit of our neural system?',
    [
      'Neuron',
      'Neutron',
      'Nephron',
      'Nucleon',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the basic unit of our excretory system?',
    [
      'Nephron',
      'Neutron',
      'Neuron',
      'Nucleon',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the unit of wavelength?',
    [
      'Meter',
      'Faraday',
      'Diopter',
      'Hertz',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the frequency range of white light?',
    [
      '4 * 1014 to 8 * 1014',
      '5 * 1014 to 8 * 1014',
      '4 * 1014 to 9 * 1014',
      '5 * 1014 to 8 * 1014',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the color of AgBr?',
    [
      'Yellow',
      'Brown',
      'White',
      'Blue',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the other name of Newtons first law of motion?',
    [
      'Law of inertia',
      'Change in momentum',
      'onstant momentum',
      'Action-reaction',
    ],
    'c2',
  ),
  QuizQuestion(
    ' According to newtons second law of motion, change in momentum per unit time is equal to ____.?',
    [
      'Force',
      'Energy',
      'Acceleration',
      'Work',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the color of SO2 gas?',
    [
      'Colorless',
      'Blue',
      'Grey',
      'Brown',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the color of CuSO4?',
    [
      'White',
      'Brown',
      'Blue',
      'Orange',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the S.I unit of electric charge?',
    [
      'Coulomb',
      'Ampere',
      'Faraday',
      'Ohm',
    ],
    'c2',
  ),
  QuizQuestion(
    ' How many carbon atoms are present in heptane?',
    [
      '7',
      '8',
      '6',
      '5',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the chemical formula of benzene?',
    [
      'C6H6',
      'C6H4',
      'C8H6',
      'C6H8',
    ],
    'c2',
  ),
  QuizQuestion(
    ' What is the atomic number of phosphorus?',
    [
      '15',
      '12',
      '14',
      '13',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Which of the following quantity increases in a group when we move from top to bottom?',
    [
      'Atomic size',
      'Valency',
      'Electronegativity',
      'Ionization energy',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the PH range of acids?',
    [
      '0 - 7',
      '7 - 14',
      '1 - 7',
      '7 - 15',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Name the non-metals which have high melting and boiling point?',
    [
      'Diamond',
      'Cesium',
      'Gallium',
      'Lead',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Name the metal which is most ductile?',
    [
      'Gold',
      'Silver',
      'Copper',
      'Iron',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the S.I unit of current?',
    [
      'Ampere',
      'Volt',
      'Ohm',
      'Coulomb',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the S.I unit of potential difference??',
    [
      'Volt',
      'Ampere',
      'Ohm',
      'Coulomb',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Name the veins that carry oxygenated blood from the heart to other parts of the body??',
    [
      'Arteries',
      'Kidney',
      'Both (a) and (b)',
      'None of these',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Name the part of the body on which coronavirus affects the most?',
    [
      'Lungs',
      'Kidney',
      'Liver',
      'Heart',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Name the part of the eye on which image is formed?',
    [
      'cornea',
      'Lens',
      'Optical Nerves',
      'Brain',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Which of the following diseases is caused by dog bites?',
    [
      'Rabies',
      'Madness',
      'Color blindness',
      'Scurvy',
    ],
    'c4',
  ),
  QuizQuestion(
    ' Which device is used for measuring air pressure?',
    [
      'Barometer',
      'Voltmeter',
      'Ammeter',
      'Seismograph',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the basic principle of an electric generator?',
    [
      'Law of constant momentum',
      'Flaming Left-Hand Rule',
      'Ohms Law',
      'Law of inversion and conversion',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the S.I unit of lens power?',
    [
      'Diopter',
      'Joule',
      'Hertz',
      'Calorie',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the S.I unit of resistance?',
    [
      'Ohm',
      'Coulomb',
      'Volt',
      'Ampere',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the chemical formula of alcoho?',
    [
      'C2H5OH',
      'C2H5O',
      'C2H5COOH',
      'C2H5',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the name of juice secreted from the gall bladder?',
    [
      'Bile juice',
      'Saliva',
      'Maltase',
      'Hydrochloric acid',
    ],
    'c4',
  ),
  QuizQuestion(
    'What is the scientific name of humans?',
    [
      'Homo sapiens',
      'Rana tigrina',
      'Mangifera indica',
      'Homo species',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the scientific name of frog?',
    [
      'Anura',
      'Homo Sapiens',
      'Felis catus',
      'Magnifera indica',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the name of farming in which the domestication of hens is involved?',
    [
      'Poultry culture',
      'Apiculture',
      'None of these',
      'Pisci culture',
    ],
    'c4',
  ),
  QuizQuestion(
    ' What is the pH value of the human body?',
    [
      '7.0 to 7.8',
      '7.0 to 9.8',
      '6.1 to 6.3',
      '5.0 to 5.8',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the following are called "Key Industrial animals"?',
    [
      'Primary consuumers',
      'Producers',
      'Tertiary consumers',
      'None of the above',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given amendments made it compulsory for the president to consent to the constitutional Amendment bills?',
    [
      '24th',
      '27th',
      '22nd',
      '29th',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Elections to panchayats in state are regulated by?',
    [
      'State Election Commission',
      'Election Commission of India',
      'Nagar Nigam',
      'Gram panchayat',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the following Himalayan regions is called "Shivaliks"?',
    [
      'Outeer Himalayas',
      'Lower Himalayas',
      'Upper Himalayas',
      'Inner Himalayas',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Forming of Association in India is?',
    [
      'Fundamental Right',
      'Natural Right',
      'Illegal Right',
      'Legal Right',
    ],
    'c1',
  ),
  QuizQuestion(
    ' The Samkhya School of Philosophy was founded by?',
    [
      'Kapila',
      'Gopala',
      'Mahipala',
      'Gautam Buddha',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Pustaz grasslands are situated at?',
    [
      'Hungary',
      'South Africa',
      'USA',
      'China',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Right to emergency medical aid is a?',
    [
      'Fundamental Right.',
      'Constitutional Right',
      'Illegal Right',
      'Legal Right',
    ],
    'c1',
  ),
  QuizQuestion(
    ' On the recommendation of which of the given committee, the abolition of reservation of items for the small-scale sector in industry is considered?',
    [
      'Abid Hussain Committee',
      'Ajit Kumar Committee',
      'Narasimhan Committee',
      'Lohia Committee',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Chelaiya Samiti is related to which of the following?',
    [
      'Tax reforms',
      'Insurance sector',
      'Health Sector',
      'Banking sector',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given devices is used for counting blood cells?',
    [
      'Hemocytometer',
      'Hmelethometer',
      'Spyscometer',
      'Hamosytometer',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given compounds is used to make fireproof clothing?',
    [
      'Aluminum Sulphate',
      'Aluminum chloride',
      'Magnesium Sulphate',
      'Magnesium Chloride',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given cities is located on the bank of river Ganga?',
    [
      'Patna',
      'Gwalior',
      'Bhopal',
      'Mathura',
    ],
    'c1',
  ),
  QuizQuestion(
    ' The driving force of an ecosystem is?',
    [
      'Solar Energy',
      'Carbon Mono oxide',
      'Biogas',
      'Carbon dioxide',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given is a disease caused by protozoa?',
    [
      'Kala-azar',
      'Chicken Pox',
      'Typhoid',
      'Cancer',
    ],
    'c1',
  ),
  QuizQuestion(
    ' The term "Samantas" is usually seen in the medieval history of India about?',
    [
      'Big Landlords',
      'Servants',
      'Queens',
      'Artists',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Which of the given coins was known as "Karshapana" in ancient literature??',
    [
      'Punch marked coins',
      'Gold coins',
      'Bronze coins',
      'Iron coins',
    ],
    'c1',
  ),
  QuizQuestion(
    ' Digestion of food in human beings begins in which part of the alimentary canal?',
    [
      'Mouth',
      'Liver',
      'Kidney',
      'Large intestine',
    ],
    'c1',
  ),
  QuizQuestion(
    ' When the metal reacts with dilute acid, which gas is formed?',
    [
      'Hydrogen',
      'Neon',
      'Helium',
      'Carbon Dioxide',
    ],
    'c1',
  ),
  QuizQuestion(
    ' What is the name of the lower layer of the Earth three concentric layers?',
    [
      'SIMA',
      'SAIL',
      'SAMA',
      'SIAL',
    ],
    'c3',
  ),
  QuizQuestion(
      ' The term "barani" refers to in the context of agriculture?',
      [
        'Rainfed farming',
        'Dryland farming',
        'Mixed farming',
        'None of these',
      ],
      'c3'),
  QuizQuestion(
      ' Which canyon is known as "The Grand Canyon of India" or The Arizona of India?',
      [
        'Gandikota Canyon',
        'Colca Canyon',
        'Copper Canyon',
        'Grand Canyon',
      ],
      'c3'),
  QuizQuestion(
      ' Which of the given vitamin is a water-soluble vitamin?',
      [
        'Vitamin B',
        'Vitamin A',
        'Vitamin K',
        'Vitamin D',
      ],
      'c3'),
  QuizQuestion(
      ' Which of the following is responsible for nitrogen fixation?',
      [
        'Bacteria',
        'Fungus',
        'Virus',
        'Insects',
      ],
      'c3'),
  QuizQuestion(
      ' Press Council of India is a?',
      [
        'The statutory quasi-judicial body',
        'None of these.',
        'Profitable organization',
        'The constitutional quasi-judicial body',
      ],
      'c3'),
  QuizQuestion(
      ' Population dividend means?',
      [
        'The youthful age structure of a population',
        'Total no of the population above 60',
        'Migration of people from the poorer region to richer region',
        'The total population of the world',
      ],
      'c3'),
  QuizQuestion(
      ' Who among the following decides if an individual Bill is a Money Bill or not?',
      [
        'Speaker of Lok Sabha',
        'Member of Lok Sabha',
        'President',
        'Prime Minister',
      ],
      'c3'),
  QuizQuestion(
      '"Rashtriya Swasthya Bima Yojana" Launched under Social Security Act 2008 Involves ',
      [
        'Only Unorganized sector workers',
        'All of the above',
        'Only social workers',
        'Only rural workers',
      ],
      'c3'),
  QuizQuestion(
      'Which of the given vitamins is responsible for blood clotting? ',
      [
        'Vitamin K',
        'Vitamin A',
        'Vitamin B',
        'Vitamin D',
      ],
      'c3'),
  QuizQuestion(
      'Who is the author of the book titled "Tipane Kashmirchi"? ',
      [
        'Arun Karmakar',
        'Arun Jaitley',
        'Arun Sharma',
        'Manoj Sinha',
      ],
      'c3'),
  QuizQuestion(
      ' Gibraltar straits links which of the following?',
      [
        'The Atlantic Ocean and the Mediterranean Sea',
        'The Red Sea and the Atlantic Ocean',
        'The Mediterranean Sea and the Red Sea',
        'The Pacific Ocean and the Mediterranean Sea',
      ],
      'c3'),
  QuizQuestion(
      ' Which of the given states or U.T(Union Territories) has the least number of females per 1000 males as per the Census 2011?',
      [
        'Daman and Diu',
        'Meghalaya',
        'Andaman Nicobar',
        'Haryana',
      ],
      'c3'),
  QuizQuestion(
      ' Nepenthes Khasiana an endangered and rare plant found in',
      [
        'Meghalaya',
        'Madhya Pradesh',
        'Orrisa',
        'Bihar',
      ],
      'c3'),
  QuizQuestion(
    ' Which of the given bio transformations gives maximum energy to the human body?',
    [
      'ADP-ATP',
      'AMP-ADP',
      'ACP-AMP',
      'AMP-ATP',
    ],
    'c3',
  ),
  QuizQuestion(
      '  The hero of the Malvikagnimitram of Kalidas is associated with which of the given dynasties?',
      [
        'The Sunga Dynasty',
        'Pallava Dynasty',
        'Magadha Dynasty',
        'Vakataka Dynasty',
      ],
      'c3'),
  QuizQuestion(
      ' Where is Lomus Rishi Cave located?',
      [
        'Gaya',
        'Varanasi',
        'Nasik',
        'Bhubaneswar',
      ],
      'c3'),
  QuizQuestion(
      ' The tropic of cancer does pass through which state of India?',
      [
        'Madhya Pradesh',
        'Bihar',
        'Andhra Pradesh',
        'Uttar Pradesh',
      ],
      'c3'),
  QuizQuestion(
      ' Who among the given had translated the Upanishads from Sanskrit to Persian?',
      [
        'Dara Shukoh',
        'Babar',
        'Mirza Galib',
        'Abul Fazal',
      ],
      'c3'),
  QuizQuestion(
      'Musi is a tributary of which of the given rivers? ',
      [
        'Krishna',
        'Ganga',
        'Kaveri',
        'Chambal',
      ],
      'c3'),
  QuizQuestion(
      'What\'s the purpose of a StatefulWidget?',
      [
        'Update UI as data changes',
        'Update data as UI changes',
        'Ignore data changes',
        'Render UI that does not depend on data',
      ],
      'c2'),
  QuizQuestion(
      'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
      [
        'StatelessWidget',
        'StatefulWidget',
        'Both are equally good',
        'None of the above',
      ],
      'c4'),
  QuizQuestion(
      'What happens if you change data in a StatelessWidget?',
      [
        'The UI is not updated',
        'The UI is updated',
        'The closest StatefulWidget is updated',
        'Any nested StatefulWidgets are updated',
      ],
      'c4'),
  QuizQuestion(
      'How should you update data inside of StatefulWidgets?',
      [
        'By calling setState()',
        'By calling updateData()',
        'By calling updateUI()',
        'By calling updateState()',
      ],
      'c3'),
];
