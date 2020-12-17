import 'dart:math';
import 'package:smart_select/smart_select.dart';

const optionsDiabetesTherapy = [
  ["", ""],
  ["oral medication", "oral medication"],
  ["injectables", "injectables"],
  ["Diet", "Diet"],
  ["None", "None"]
];

const optionsGender = [
  ["", ""],
  ["Male", "Male"],
  ["Female", "Female"]
];

List<S2Choice<String>> genders = [
  S2Choice<String>(value: 'Male', title: 'Male'),
  S2Choice<String>(value: 'Female', title: 'Female'),
];

const optionsIntraOcularPressure = [
  ["", ""],
  ["mmHg", "mmHg"],
  ["Not Done", "Not Done"]
];

const optionsSignsDR = [
  ["", ""],
  ["Yes", "Yes"],
  ["No", "No"],
  ["Don't Know", "Don't Know"]
];

const optionsSymptoms = [
  ["", ""],
  ["Blurred vision", "Blurred vision"],
  ["Change of spectacles", "Change of spectacles"],
  ["Dark empty areas in your vision", "Dark empty areas in your vision"],
  ["Discharge", "Discharge", "Change of spectacles"],
  ["Dryness of eyes", "Dryness of eyes"],
  ["Flashes of light", "Flashes of light"],
  ["Floaters", "Floaters"],
  ["Fluctuating vision", "Fluctuating vision"],
  ["Impaired color vision", "Impaired color vision"],
  ["Itchiness", "Itchiness"],
  ["Pain", "Pain"],
  ["Poor vision", "Poor vision"],
  ["Redness", "Redness"],
  ["Stys", "Stys"]
];

const optionTypeDiabetes = [
  ["", ""],
  ["DM 1", "DM 1"],
  ["DM 2", "DM 2"],
  ["Gestational", "Gestational"],
];

const optionsVisualAquity = [
  ["", ""],
  ["6/6", "6/6"],
  ["6/9", "6/9"],
  ["6/12", "6/12"],
  ["6/18", "6/18"],
  ["6/24", "6/24"],
  ["6/36", "6/36"],
  ["/6/60", "/6/60"],
  ["5/60", "5/60"],
  ["Light Perception", "Light Perception"],
  ["No Light Perception", "No Light Perception"],
  ["Not Done", "Not Done"]
];

final cities = [
  'Albuquerque',
  'Arlington',
  'Atlanta',
  'Austin',
  'Baltimore',
  'Boston',
  'Charlotte',
  'Chicago',
  'Cleveland',
  'Colorado Springs',
  'Columbus',
  'Dallas',
  'Denver',
  'Detroit',
  'El Paso',
  'Fort Worth',
  'Fresno',
  'Houston',
  'Indianapolis',
  'Jacksonville',
  'Kansas City',
  'Las Vegas',
  'Long Island',
  'Los Angeles',
  'Louisville',
  'Memphis',
  'Mesa',
  'Miami',
  'Milwaukee',
  'Nashville',
  'New York',
  'Oakland',
  'Oklahoma',
  'Omaha',
  'Philadelphia',
  'Phoenix',
  'Portland',
  'Raleigh',
  'Sacramento',
  'San Antonio',
  'San Diego',
  'San Francisco',
  'San Jose',
  'Seattle',
  'Tucson',
  'Tulsa',
  'Virginia Beach',
  'Washington',
];

final categories = [
  'Brunch',
  'Burgers',
  'Coffee',
  'Deli',
  'Dim Sum',
  'Indian',
  'Italian',
  'Mediterranean',
  'Mexican',
  'Pizza',
  'Ramen',
  'Sushi',
];

final _words = [
  'Bar',
  'Deli',
  'Diner',
  'Fire',
  'Grill',
  'Drive Thru',
  'Place',
  'Best',
  'Spot',
  'Trattoria',
  'Steakhouse',
  'Churrasco',
  'Tavern',
  'Cafe',
  'Pop-up',
  'Yummy',
  'Belly',
  'Snack',
  'Fast',
  'Turbo',
  'Hyper',
  'Prime',
  'Eatin\'',
];

final _reviewTextPerRating = {
  1: [
    'Would never eat here again!',
    'Such an awful place!',
    'Not sure if they had a bad day off, but the food was very bad.'
  ],
  2: [
    'Not my cup of tea.',
    'Unlikely that we will ever come again.',
    'Quite bad, but I\'ve had worse!'
  ],
  3: [
    'Exactly okay :/',
    'Unimpressed, but not disappointed!',
    '3 estrellas y van que arden.'
  ],
  4: [
    'Actually pretty good, would recommend!',
    'I really like this place, I come quite often!',
    'A great experience, as usual!'
  ],
  5: [
    'This is my favorite place. Literally',
    'This place is ALWAYS great!',
    'I recommend this to all my friends and family!'
  ],
};

final random = Random();

String getRandomReviewText(int rating) {
  final reviews = _reviewTextPerRating[rating];
  return reviews[random.nextInt(reviews.length)];
}

String getRandomName() {
  final firstWord = random.nextInt(_words.length);
  var nextWord;
  do {
    nextWord = random.nextInt(_words.length);
  } while (firstWord == nextWord);
  return '${_words[firstWord]} ${_words[nextWord]}';
}

String getRandomCategory() {
  return categories[random.nextInt(categories.length)];
}

String getRandomCity() {
  return cities[random.nextInt(cities.length)];
}

String getRandomPhoto() {
  final photoId = random.nextInt(21) + 1;
  return 'https://storage.googleapis.com/firestorequickstarts.appspot.com/food_$photoId.png';
}
