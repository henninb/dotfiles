import  java.time.*
engineerNumber = 6
daysRotation = 3
date = LocalDate.parse('Apr 24, 21', 'MMM d, yy')
now = LocalDate.now()
diff = now - date
dayCountOne = engineerNumber * daysRotation
interval = diff / dayCountOne as Integer
dayCount = (engineerNumber * daysRotation) + (interval * dayCountOne)
futureDate = date + dayCount
