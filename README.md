# The {datalark} package!

Akin to the mudlark searching for treasures on the foreshore, the datalark often finds themselves having to search through messy data sets before finding data treasures! Clean data are essential to maintain data integrity, as improper cleaning can result in inaccurate or missing data. The {datalark} package aids in the data cleaning process of alpha-numeric (open-text) responses given by participants.

When alpha-numeric responses are allowed in a response field such as number of hours worked, participants often give more than just a numeric estimate. Often, in their desire to be as accurate as possible, they will provide numeric ranges; use symbols such as “~”, “+”, or “<“; or will use words such as “approximate”. When this is not minimized through the restriction of response fields to numeric input only, it can require a lot of data cleaning. 

Much like the mudlark carefully preserving their finds, the datalark maintains the integrity of the data to preserve data quality. This package consists of 5 functions which help the datalark to clean data whilst protecting against inadvertant damage caused my improper processing.

## Installation

To install the {datalark} package, use the {devtools} package to download directly from this GitHub repository:

```
devtools::install_github("kbelisar/datalark”)
```

## change_measures()

Participants sometimes give responses in a different unit of measurement than requested. The alternative unit of measurement may accompany their response, allowing for transformation into the proper unit of measurement. This function will transform common units of measurement found in participant data that are within a one-unit magnitude of one another. For example, months can be transformed into years or weeks, but cannot be transformed into minutes. This function will also transform the most common imperial and metric measurements, associated with weight and height measurements. 

This function requires two arguments (`from` and `to`), and the table below shows which units of measurement can be transformed from or into:

| Unit 1      | &#8592; &#8594; |  Unit 2 |
|-------------|-----------------|---------|
| Years       | &#8592; &#8594; | Months  |
| Months      | &#8592; &#8594; | Weeks   |
| Weeks       | &#8592; &#8594; | Days    |
| Days        | &#8592; &#8594; | Hours   |
| Hours       | &#8592; &#8594; | Minutes |
| Kilograms   | &#8592; &#8594; | Pounds  |
| Grams       | &#8592; &#8594; | Ounces  |
| Centimeters | &#8592; &#8594; | Inches  |
          
## clean_measures()

Participants will sometimes provide the unit of measurement in their response for precision. Although well-intentioned, this requires additional cleaning, and is complicated when symbols or other desciptive approximations are given such as "approx.", "~", "<", or "max". 

This function can clean the following units of measurement, which is selected using the `type` argument:

- Minutes
- Hours
- Days
- Weeks
- Months
- Years
- Grams
- Ounces
- Kilograms
- Pounds
- Centimetres
- Inches

This function will also clean the following symbols, if the argument `symbols` is set to TRUE: "<", ">" ,"~", "+", "?", "??". Setting the `symbols` argument to TRUE will also remove words relating to approximations which are often seen in participant responses when the text field is open-ended: "less than", "greater than", "minimum", "maximum", "approximately", "around", "roughly".

## clean_money()

Similar to the `clean_measures()` function, this function is specifically for monetary amounts and will remove the symbols and related estimates that are common in responses to questions about earnings or money spent. This function can also transform values when a "k" is used to denote thousands when the argument `transform` is set to TRUE.

## rangle_calc()

Participants, eager to be both detailed and precise in their resonses, will often give a range of values as an approximation, and can be cumbersome to clean! This function carefully transforms ranges into the average between the two values given, whilst also preserving all non-range responses (including alpha-numeric responses). This is especially important given that there may be additional text-based responses given that either can be handled using the other functions in this package, or in the case of complicated responses, can be retained and handled manually.

## zero_measures()

When alpha-numeric responses are allowed, participants can sometimes write their response of 0 as "zero", "none", or "null". This function will transform these responses into the numeric response of 0. It will also transform any responses written by participants as "NA" to the numeric response of 0 whilst retaining true missing values, when the argument `include.na` is set to TRUE. See the examples using the sample data below.

# Examples - Sample Data

This sample data ('dl_data') provided by this package are a mock-up of common response formats seen when alpha-numeric responses are allowed. The data are from 15 fictional participants and are as follows:

| Variable Name    | Description                    |
|------------------|--------------------------------|
| ID               | Unique participant identifier  |
| employment_hours | Average number of hours worked per week |
| yearly_income    | Gross yearly income |
| minutes_exercised| Average number of hours spent engaged in moderate activity/ exercise per week |
| alc_endorsed    | Endorsement of alcohol consumption within the past month |
| alc_amount      | Amount of alcohol consumed on a typical day measured in ounces [if alc_endorsed == 1] |

## Employment Hours

Examining the 'employment_hours' variable, there are approximations present in the responses using both text and symbols. The `clean_measures()` function can be used to clean these responses:

```
dl_data$employment_hours2 <- clean_measures(dl_data$employment_hours, type = "hours", symbols = T)
```

As seen in the original data, participant ID # 10 has additional pertinent information surrounding the fact that they work 2 jobs at 20 hours each. The `clean_measures()` function identified that there was additional text in the given response, and retained the response (including the word 'hours') in its entirety to allow for manual processing.

The variable also contains a lot of ranges that were given as responses, and would benefit from utilizing the `range_calc()` function:

```
dl_data$employment_hours3 <- range_calc(dl_data$employment_hours2)
```

These two functions, `clean_measures()` and `range_calc()` greatly reduced the number of cases requiring manual review, and introduce consistency into the data cleaning process. The changes after applying each function to the data are seen below:

|ID | employment_hours | employment_hours2 | employment_hours3 |
|---|------------------|-------------------|-------------------|
| 1 | 0-20             | 0-20              | 10                |
| 2 | 30               | 30                | 30                |
| 3 | 0-15             | 0-15              | 7.5               |
| 4 | 32+              | 32                | 32                |
| 5 | 15-45            | 15-45             | 30                |
| 6 | 10+              | 10                | 10                |
| 7 | 20 approx        | 20                | 20                |
| 8 | 10 - 20          | 10 - 20           | 15                |
| 9 | < 24             | 24                | 24                |
|10 | two part-time jobs ~ 20 hours each | two part-time jobs ~ 20 hours each | two part-time jobs ~ 20 hours each |
|11 | 45               | 45                | 45                |
|12 | 20-25            | 20-25             | 22.5              |
|13 | about 30         | 30                | 30                |
|14 | 10-30 at first job; 50-10 at second | 10-30 at first job; 50-10 at second | 10-30 at first job; 50-10 at second |
|15 | ~24              | 24                | 24                |

## Yearly Income

Examining the 'yearly_income' variable, there are approximations in responses given, as well as thousands of dollars expressed with a "k". To clean these responses as well as transform the "k" notation into "000", the `clean_money()` function can be used:

```
dl_data$yearly_income2 <- clean_money(dl_data$yearly_income, transform = T)
```

In the sample data, participant ID # 10 who identified that they work 2 jobs in the previous hours employed question, has also identified the amount that each job brings in through their response of "20k each". The `clean_money()` function left this response unchanged in order to maintain the integrity of the data for later manual processing.

|ID | yearly_income     |   yearly_income2  |
|---|-------------------|-------------------|
| 1 | 20000             | 20000             |
| 2 | 30000             | 30000             |
| 3 | approx 20k        | 20000             |
| 4 | 45000             | 45000             |
| 5 | ~30000            | 30000             |
| 6 | ~35k              | 35000             |
| 7 | 30000             | 30000             |
| 8 | 10000             | 10000             |
| 9 | 25000             | 25000             |
|10 | 20k each          | 20k each          |
|11 | 90000+            | 90000             |
|12 | 30 k              | 30000             |
|13 | approx. 40000     | 40000             |
|14 | 55k               | 55000             |
|15 | ~22 k             | 22000             |

## Minutes Exercised

Taking a look at the 'minutes_exercised' variable, many many of the responses expressed in minutes include the word "minutes" (or an equivalent short-form). Additionally, many responses are expressed in hours. Both the `clean_measures()` and the `change_measures()` functions would be useful in cleaning these data.


```
dl_data$minutes_exercised2 <- clean_measures(dl_data$minutes_exercised, type = "minutes", symbols = T)
dl_data$minutes_exercised3 <- change_measures(dl_data$minutes_exercised2, from = "hours", to = "minutes")
```

|ID | minutes_exercised | minutes_exercised2| minutes_exercised3|
|---|-------------------|-------------------|-------------------|
| 1 |2 hrs              | 2 hours           |  120              |               
| 2 |30                 | 30                |  30               |
| 3 |60 min             | 60                |  60               |
| 4 |2hrs               | 2hrs              |  120              |
| 5 |approx 30 min.     | 30                |  30               |
| 6 |0.5 hours          | 0.5 hours         |  30               |
| 7 |120 minutes        | 120               |  120              |
| 8 |60                 | 60                |  60               |
| 9 |1 hour             | 1 hour            |  60               |   
|10 |100                | 100               |  100              |   
|11 |roughly 60         | 60                |  60               |  
|12 |180 min            | 180               |  180              |      
|13 |50                 | 50                |  50               |    
|14 |45 mins            | 45                |  45               |   
|15 |1 hr               | 1 hr              |  60               |  

## Consumed Weekly Alcohol Amount

By examining both the 'alc_amount' and 'alc_endorsed' variables, it can be seen that the branching logic question 'alc_endorsed' used to administer the 'alc_amount' question, was not implemented for the first 9 participants. Since 'alc_endorsed' responses are not available for these participants, those who would not have endorsed alcohol consumption in the 'alc_endorsed' question have responses to 'alc_amount' which are reflective of consuming no alcohol. The `zero_measures()` function can be used to transform these values to 0 whilst still maintaining true missing values of those who did not answer this question.

```
dl_data$alc_amount2 <- zero_measures(dl_data$alc_amount, include.na = T)
```

|ID | alc_endorsed      | alc_amount        | alc_amount2       |
|---|-------------------|-------------------|-------------------|
| 1 |                   | zero              | 0                 |
| 2 |                   | 4 oz              | 4 oz              |
| 3 |                   | N/A               | 0                 |
| 4 |                   | 12                | 12                |
| 5 |                   | none              | 0                 |
| 6 |                   | 8 ounces          | 8 ounces          |
| 7 |                   | NA                | 0                 |
| 8 |                   | 16                | 16                |
| 9 |                   |                   |                   |
|10 | 0                 |                   |                   |
|11 | 1                 | 12 oz             | 12. oz            |           
|12 | 1                 | 4                 | 4                 |
|13 | 1                 | 20 ounces         | 20 ounces         |                 
|14 | 0                 |                   |                   |   
|15 | 1                 | 4 oz              | 4 oz              |


In the original variable, participant ID # 1, 3, 5, and 7 all have a response of zero for the amount of alcohol consumed, but are expressed in different ways. Specifically, participant ID # 3 and 7 wrote their response as "N/A" and "NA" (respectively). These responses differ from participant ID # 9 who has true missing data, as well as participant ID # 10 and 14 who did not receive the 'alc_amount' question because they answered "no (0)" to the 'alc_endorsed' question.

Using the `zero_measures()` function, participants who answered the equivalent to zero alcohol consumption, had their responses transformed to a numeric zero, whilst those who were truly missing a response for this question retained their missing response. Further data cleaning would see a response of zero entered for participant IDs # 10 and 14 who did not endorse alcohol consumption, whilst particpant ID # 10 would retain a true missing (NA) response as there is no way to determine whether they would have endorsed alcohol consumption or not. And finally, the `clean_measures()` function can be applied to remove "ounces" written in responses:

```
dl_data$alc_amount2[dl_data$alc_endorsed==0] <- 0
dl_data$alc_amount3 <- clean_measures(dl_data$alc_amount2, type = "ounces", symbols = T)
```

# A Final Note

Of course, good data collection techniques would minimize the need for this type of cleaning. The type of responses allowed to be captured in the survey response field is one way to avoid the types of messy data seen with alpha-numeric responses. However, this alone does not ensure good data quality. Improvements to the question being asked and/or the instructions being given to participants must be critically assessed on how they can improve the accuracy of what is being collected.

