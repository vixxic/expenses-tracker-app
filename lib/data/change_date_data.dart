// Data bulan
List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

String changeDataFormat(DateTime date) {
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
